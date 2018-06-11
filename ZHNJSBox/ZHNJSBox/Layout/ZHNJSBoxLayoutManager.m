//
//  ZHNJSBoxLayoutManager.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/27.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxLayoutManager.h"
#import "ZHNJSBoxDataBox.h"
#import "Masonry.h"
#import "JSValue+judgeNil.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


@implementation ZHNJSBoxLayoutManager
+ (id)OCLayoutPropertyDealWithLayoutMaker:(id)maker porperty:(id)property {
    NSString *pro = [property toString];
    id layoutMaker = [maker toObject];
    id returnMaker;
    SuppressPerformSelectorLeakWarning(
        returnMaker = [layoutMaker performSelector:NSSelectorFromString(pro)];
    );
    return returnMaker;
}

+ (id)OCLayoutRelationDealWithLayoutMaker:(JSValue *)maker relationFunc:(JSValue *)relationFunc arg:(JSValue *)arg {
    // 判断是否传递了参数
    if (arg.isNil) {
        return [maker toObject];
    }

    // 调用方法
    id layoutMaker = [maker toObject];
    NSString *funcName = [relationFunc toString];
    
    if ([funcName containsString:@"qualTo"]) {
        MASConstraint * (^idMakeBlock)(id);
        SuppressPerformSelectorLeakWarning(
            idMakeBlock = [layoutMaker performSelector:NSSelectorFromString(funcName)];
        );
        id ocArg = [arg toObject];
        // 数据需要用MASBoxValue包一下，因为equalto是后面不能接size之类的数据格式
        return idMakeBlock(MASBoxValue(ocArg));
    }else {
        MASConstraint * (^floatMakeBlock)(CGFloat);
        SuppressPerformSelectorLeakWarning(
            floatMakeBlock = [layoutMaker performSelector:NSSelectorFromString(funcName)];
        );
        return floatMakeBlock([[arg toObject] floatValue]);
    }
}
@end
