//
//  ZHNJSBoxUIManager.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/25.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxUIParseManager.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSValue+judgeNil.h"
#import "UIView+mapViewId.h"

@implementation ZHNJSBoxUIParseManager
+ (UIView *)parsingViewForJSValue:(JSValue *)jsValue superView:(UIView *)superView idMapViewDict:(NSMutableDictionary *)mapDict{
    // 转换类型
    NSDictionary *viewDict = [jsValue toDictionary];
    // view 类型
    NSString *viewType = viewDict[@"type"];
    // 解析出对应的ui class
    NSString *viewClassName = [self classNameForIdentity:viewType];
    // ui参数
    NSDictionary *props = viewDict[@"props"];
    // 根据类和参数生成view
    UIView *view = (UIView *)[[NSClassFromString(viewClassName) alloc]init];
    [superView addSubview:view];
    // 特殊情况的处理
    // uibutton
    if ([viewClassName isEqualToString:NSStringFromClass([UIButton class])]) {
        JSValue *btnType = jsValue[@"props"][@"type"];
        if (!btnType.isNil) {
            view = [UIButton buttonWithType:[[btnType toObject] integerValue]];
        }
    }
    // id->view 存一下
    if ([props.allKeys containsObject:@"id"]) {
        NSString *key = props[@"id"];
        mapDict[key] = view;
    }else {
        mapDict[viewType] = view;
    }
    // 属性设置
    NSArray *noNeedTransKeys = @[@"template",@"header",@"footer",@"actions",@"data"];
    for (NSString *key in props.allKeys) {
        id obj;
        if ([noNeedTransKeys containsObject:key]) {// 不能转换为原生数据格式的
            obj = jsValue[@"props"][key];
        }else {
            obj = [props objectForKey:key];
        }
        [view setValue:obj forKey:key];
    }
    
    // 手势事件
    [view setValue:jsValue[@"events"] forKey:@"events"];
    
    return view;
}

+ (NSString *)classNameForIdentity:(NSString *)identity {
    // 首字母大写
    identity = [identity capitalizedString];
    NSString *viewClassName = [NSString stringWithFormat:@"UI%@",identity];
    NSString *mapClassName = [[self _nativeClassMapping] objectForKey:viewClassName];
    viewClassName = mapClassName ? mapClassName : viewClassName;
    return viewClassName;
}

+ (NSDictionary *)_nativeClassMapping {
    return @{
             @"UIInput":@"UITextField",
             @"UIImage":@"UIImageView",
             @"UIWeb":@"WKWebView",
             @"UITab":@"UISegmentedControl"
             };
}
@end
