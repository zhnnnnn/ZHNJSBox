//
//  ZHNJSBoxUIRenderManager.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/9.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxRenderManager.h"
#import "Masonry.h"
#import "ZHNJSBoxUIParseManager.h"
#import "UIView+ZHNJSBoxUIView.h"
#import "UIView+mapViewId.h"
#import "ZHNJSBoxEngine.h"

@implementation ZHNJSBoxRenderManager
+ (void)renderUIWithJSRender:(JSValue *)jsRender superView:(UIView *)superView idMapDict:(NSMutableDictionary *)mapDict{
    JSValue *jsViews = jsRender[@"views"];
    NSArray *views = [jsViews toArray];
    if (views) {
        NSInteger count = views.count;
        mapDict = mapDict ? mapDict : superView.mapViewDict;
        [self _renderUIWithJsRender:jsRender[@"views"] superView:superView viewCount:count mapViewDict:mapDict];
    }
}

+ (void)renderUIWithJSViews:(id)jsViews superView:(UIView *)superView {
    if (jsViews) {
        NSInteger count;
        if ([jsViews isKindOfClass:[JSValue class]]) {
            count = [[jsViews toArray] count];
        }else if ([jsViews isKindOfClass:[NSArray class]]) {
            count = [jsViews count];
        }
        
        // 切换上下文写在这里有待验证是否是完美方案
        [ZHNJSBoxEngine engineSwitchIDMapViewContext:superView];
        [self _renderUIWithJsRender:jsViews superView:superView viewCount:count mapViewDict:superView.mapViewDict];
        [ZHNJSBoxEngine engineDefaultIDMapViewContext];
    }
}

+ (void)_renderUIWithJsRender:(JSValue *)jsRender superView:(UIView *)superView viewCount:(NSInteger)viewCount mapViewDict:(NSMutableDictionary *)viewMapDict {
    for (int i = 0; i < viewCount; i++) {
        // 解析出view
        JSValue *viewJSValue = jsRender[i];
        // 布局        
        UIView *view = [ZHNJSBoxUIParseManager parsingViewForJSValue:viewJSValue superView:superView idMapViewDict:viewMapDict];
        JSValue *layoutJSFunc = viewJSValue[@"layout"];
        NSString *funcStr = [layoutJSFunc toString];
        if ([funcStr isEqualToString:@"fill"]) {// 语法糖
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
        }else if ([funcStr isEqualToString:@"center"]) {// 语法糖
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(superView);
            }];
        }else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                [layoutJSFunc callWithArguments:@[make,view]];
            }];
        }
        
        // 递归调用
        [self renderUIWithJSRender:viewJSValue superView:view idMapDict:viewMapDict];
    }
}

@end
