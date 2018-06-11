//
//  ZHNJSBoxUIRenderManager.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/9.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@interface ZHNJSBoxRenderManager : NSObject
// render 普通的情况 jsRender包含views
+ (void)renderUIWithJSRender:(JSValue *)jsRender superView:(UIView *)superView idMapDict:(NSMutableDictionary *)mapDict;

// render 一些特殊的情况 jsViews是一个view的数组(可以是jsvalue也可以是array)
+ (void)renderUIWithJSViews:(id)jsViews superView:(UIView *)superView;
@end
