//
//  UIView+ZHNJSBoxUIView.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIView+ZHNJSBoxUIView.h"
#import <objc/runtime.h>
#import "ZHNJSBoxJSContextManager.h"

static NSString *const EventTapped = @"tapped";
static NSString *const EventLongPressed = @"longPressed";
static NSString *const EventDoubleTapped = @"doubleTapped";

@implementation UIView (ZHNJSBoxUIView)
// 背景色
- (void)setBgcolor:(UIColor *)bgcolor {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.backgroundColor = bgcolor;
    });
}

- (UIColor *)bgcolor {
    return self.backgroundColor;
}

// 圆角
- (void)setRadius:(CGFloat)radius {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (CGFloat)radius {
    return self.layer.cornerRadius;
}

// 父视图
- (UIView *)super {
    return self.superview;
}

- (NSArray *)views {
    return self.subviews;
}

// 边框宽度
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

// 边框颜色
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

// view ID
- (void)setId:(NSString *)id {
    objc_setAssociatedObject(self, @selector(id), id, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)id {
    return objc_getAssociatedObject(self, @selector(id));
}

// 事件
- (void)setEvents:(JSValue *)events {
    NSDictionary *ocDict = [events toDictionary];
    for (NSString *key in ocDict.allKeys) {
        JSValue *jsFunc = events[key];
        [self eventsDealingWithEventName:key jsfunc:jsFunc];
    }
}

- (void)eventsDealingWithEventName:(NSString *)eventsName jsfunc:(JSValue *)jsfunc {
    [JSContextManager addJsfuncWithObject:self eventName:eventsName jsfunc:jsfunc];
    UIGestureRecognizer *ges;
    if ([eventsName isEqualToString:EventTapped]) {
        ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(normalGestureAction:)];
    }
    if ([eventsName isEqualToString:EventLongPressed]) {
        ges = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(normalGestureAction:)];
    }
    if ([eventsName isEqualToString:EventDoubleTapped]) {
        UITapGestureRecognizer *douTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(normalGestureAction:)];
        douTapGes.numberOfTapsRequired = 2;
        ges = douTapGes;
    }
    if (ges) {
       [self addGestureRecognizer:ges];
    }
}

- (void)normalGestureAction:(UIGestureRecognizer *)ges {
    if ([ges isKindOfClass:[UITapGestureRecognizer class]]) {
        if ([(UITapGestureRecognizer *)ges numberOfTapsRequired] == 1) {
            [JSContextManager callJsFuncWithObj:self eventName:EventTapped args:@[ges]];
        }else {
            [JSContextManager callJsFuncWithObj:self eventName:EventDoubleTapped args:@[ges]];
        }
    }
    if ([ges isKindOfClass:[UILongPressGestureRecognizer class]]) {
        [JSContextManager callJsFuncWithObj:self eventName:EventLongPressed args:@[ges]];
    }
}

@end
