//
//  NSMutableDictionary+ZHNJSBoxSafeSet.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/25.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "NSMutableDictionary+ZHNJSBoxSafeSet.h"

@implementation NSMutableDictionary (ZHNJSBoxSafeSet)
- (void)zhn_safeSetObject:(id)object forKey:(NSString *)key {
    if (!key) {
        return;
    }
    object = object ? object : @"";
    [self setObject:object forKey:key];
}
@end
