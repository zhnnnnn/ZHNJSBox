//
//  ZHNJSBoxFont.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxFont.h"

@implementation ZHNJSBoxFont
+ (UIFont *)fontWithValue1:(JSValue *)value1 value2:(JSValue *)value2 {
    id obj1 = [value1 toObject];
    id obj2 = [value2 toObject];
    if ([obj1 isKindOfClass:[NSNumber class]]) {
        return [UIFont systemFontOfSize:[obj1 floatValue]];
    }else {
        if ([obj1 isEqualToString:@"bold"]) {
            return [UIFont systemFontOfSize:[obj2 floatValue] weight:UIFontWeightBold];
        }
        if ([obj1 isEqualToString:@"defalt"]) {
            return [UIFont systemFontOfSize:[obj2 floatValue]];
        }
        return [UIFont fontWithName:obj1 size:[obj2 floatValue]];
    }
}
@end
