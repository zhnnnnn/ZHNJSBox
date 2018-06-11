//
//  JSContextManager.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxJSContextManager.h"

@interface ZHNJSBoxJSContextManager ()
@property (nonatomic,strong) JSContext *context;
@end

@implementation ZHNJSBoxJSContextManager
+ (instancetype)manager {
    static ZHNJSBoxJSContextManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZHNJSBoxJSContextManager alloc]init];
    });
    return manager;
}

- (void)initializeEnvironmentWithContext:(JSContext *)context {
    self.context = context;
}

- (void)clearEnvironment {
    self.context = nil;
}

- (void)addJsfuncWithObject:(id)obj eventName:(NSString *)eventName jsfunc:(JSValue *)jsfunc{
    NSString *funcName = [self _jsPropertyNameForObj:obj name:eventName];
    [self.context[@"addJsProperty"] callWithArguments:@[funcName,jsfunc]];
}

- (JSValue *)callJsFuncWithObj:(id)obj eventName:(NSString *)eventName args:(NSArray *)args {
    NSString *funcName = [self _jsPropertyNameForObj:obj name:eventName];
    return [self.context[funcName] callWithArguments:args];
}

- (void)addJsValueWithObject:(id)obj name:(NSString *)name jsValue:(JSValue *)value {
    NSString *propertyName = [self _jsPropertyNameForObj:obj name:name];
    [self.context[@"addJsProperty"] callWithArguments:@[propertyName,value]];
}

- (JSValue *)getJsValueWithObject:(id)obj name:(NSString *)name {
    NSString *propertyName = [self _jsPropertyNameForObj:obj name:name];
    return self.context[propertyName];
}

#pragma mark - pravite method
- (NSString *)_jsPropertyNameForObj:(id)obj name:(NSString *)name {
    NSString *idress = [NSString stringWithFormat:@"%p",obj];
    return [NSString stringWithFormat:@"%@_%@",idress,name];
}

@end
