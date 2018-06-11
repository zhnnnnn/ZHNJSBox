//
//  ZHNJSBoxUIManager.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/28.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxUIManager.h"
#import "ZHNJSBoxRenderManager.h"
#import "ZHNJSBoxAlertManager.h"
#import "SVProgressHUD.h"

@implementation ZHNJSBoxUIManager
+ (void)handleWithEventName:(NSString *)eventName jsValue:(JSValue *)value engine:(ZHNJSBoxEngine *)engine {
    if ([eventName isEqualToString:@"render"]) {
        [ZHNJSBoxRenderManager renderUIWithJSRender:value superView:engine.containerView idMapDict:nil];
    }
    
    if ([eventName isEqualToString:@"push"]) {
        [engine.delegate ZHNJSBoxPushAction];
        [ZHNJSBoxRenderManager renderUIWithJSRender:value superView:engine.containerView idMapDict:nil];
    }
    
    if ([eventName isEqualToString:@"alert"]) {
        [ZHNJSBoxAlertManager alertWithJSData:value];
    }
    
    if ([eventName isEqualToString:@"loading"]) {
        id obj = [value toObject];
        if ([obj isKindOfClass:[NSString class]]) {
            [SVProgressHUD showWithStatus:obj];
        }else {
            if ([obj boolValue]) {
                [SVProgressHUD showWithStatus:@"加载中"];
            }else {
                [SVProgressHUD dismiss];
            }
        }
    }
}
@end
