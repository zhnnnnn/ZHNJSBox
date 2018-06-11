//
//  ZHNJSBoxLayoutManager.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/27.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHNJSBoxLayoutManager : NSObject
// masonry里maker属性
+ (id)OCLayoutPropertyDealWithLayoutMaker:(JSValue *)maker porperty:(JSValue *)property;
// masonry里的关系
+ (id)OCLayoutRelationDealWithLayoutMaker:(JSValue *)maker relationFunc:(JSValue *)relationFunc arg:(JSValue *)arg;
@end
