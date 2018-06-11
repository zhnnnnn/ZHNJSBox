//
//  ZHNJSBoxUIManager.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/25.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHNJSBoxUIParseManager : NSObject
// 解析出对应的view
+ (UIView *)parsingViewForJSValue:(JSValue *)jsValue superView:(UIView *)superView idMapViewDict:(NSMutableDictionary *)mapDict;
// 解析对应的类名
+ (NSString *)classNameForIdentity:(NSString *)identity;
@end
