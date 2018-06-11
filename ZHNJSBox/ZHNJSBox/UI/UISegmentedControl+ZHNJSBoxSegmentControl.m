//
//  UISegmentedControl+ZHNJSBoxSegmentControl.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UISegmentedControl+ZHNJSBoxSegmentControl.h"
#import <objc/runtime.h>
#import "ZHNJSBoxJSContextManager.h"

static NSString *EventChanded = @"changed";
@implementation UISegmentedControl (ZHNJSBoxSegmentControl)
- (instancetype)init {
    if (self = [super init]) {
        [self addTarget:self action:@selector(valueChandedAction) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)valueChandedAction {
    [JSContextManager callJsFuncWithObj:self eventName:EventChanded args:@[self]];
}

- (void)setItems:(NSArray *)items {
    [items enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        [self insertSegmentWithTitle:title atIndex:idx animated:NO];
    }];
    self.selectedSegmentIndex = [self.index integerValue];
    objc_setAssociatedObject(self, @selector(items), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)items {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setIndex:(NSNumber *)index {
    self.selectedSegmentIndex = [index integerValue];
    objc_setAssociatedObject(self, @selector(index), index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)index {
    return objc_getAssociatedObject(self, _cmd);
}
@end
