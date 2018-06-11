//
//  UIView+ZHNJSBoxUIView.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxUIViewExport <JSExport>
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) UIView *super;

@property (nonatomic, strong) UIColor *bgcolor;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat smoothRadius;// TODO：不知是否是异步绘制
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) BOOL userInteractionEnabled;
@property (nonatomic, assign) BOOL multipleTouchEnabled;
@property (nonatomic, assign) BOOL clipsToBounds;
@property (nonatomic, strong) UIView *prev;
@property (nonatomic, strong) UIView *next;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, assign) BOOL opaque;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) NSInteger contentMode;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) JSValue *events;
@end

@interface UIView (ZHNJSBoxUIView) <ZHNJSBoxUIViewExport>
@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) UIView *super;

@property (nonatomic, strong) UIColor *bgcolor;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) UIView *prev;
@property (nonatomic, strong) UIView *next;
@property (nonatomic, strong) JSValue *events;
- (void)eventsDealingWithEventName:(NSString *)eventsName jsfunc:(JSValue *)jsfunc;
@end
