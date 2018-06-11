//
//  ZHNJSBoxEngine.h
//  ZHNJSBox
//
//  Created by zhn on 2018/4/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol ZHNJSBoxEngineDelegate
- (void)ZHNJSBoxPushAction;
@end

@interface ZHNJSBoxEngine : NSObject
// 初始化引擎
- (void)startEngine;
// 加载脚本
- (JSValue *)evaluateScript:(NSString *)script;
// 通过路径加载脚本
- (JSValue *)evaluateScriptWithPath:(NSString *)path;
// 父视图
@property (nonatomic,strong) UIView *containerView;
// 代理
@property (nonatomic, weak)  id <ZHNJSBoxEngineDelegate> delegate;
// 判断是否有视图
+ (BOOL)isScriptHaveRender:(NSString *)script;

// 切换上下文 (通过id获取对应的view)
+ (void)engineSwitchIDMapViewContext:(UIView *)context;
+ (void)engineDefaultIDMapViewContext;
@end
