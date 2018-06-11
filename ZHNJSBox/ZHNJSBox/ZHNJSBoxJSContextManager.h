//
//  JSContextManager.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#define JSContextManager [ZHNJSBoxJSContextManager manager]

@interface ZHNJSBoxJSContextManager : NSObject
+ (instancetype)manager;

// 初始化环境
- (void)initializeEnvironmentWithContext:(JSContext *)context;
// 清空环境
- (void)clearEnvironment;

// 添加js方法到js环境
- (void)addJsfuncWithObject:(id)obj eventName:(NSString *)eventName jsfunc:(JSValue *)jsfunc;
// 调用js方法
- (JSValue *)callJsFuncWithObj:(id)obj eventName:(NSString *)eventName args:(NSArray *)args;

// 添加js数据到js的环境
- (void)addJsValueWithObject:(id)obj name:(NSString *)name jsValue:(JSValue *)value;
// 拿到js的数据
- (JSValue *)getJsValueWithObject:(id)obj name:(NSString *)name;
@end
