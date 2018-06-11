//
//  NSString+ZHNJSEditor.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/31.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "NSString+ZHNJSEditor.h"

@implementation NSString (ZHNJSEditor)
- (NSString *)zhn_subStringToStr:(NSString *)str {
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return self;
    }else {
        return [self substringToIndex:range.location];
    }
}

- (NSString *)zhn_subStringFromStr:(NSString *)str {
    NSRange range = [self rangeOfString:str];
    if (range.location == NSNotFound) {
        return self;
    }else {
        return [self substringFromIndex:(range.location + range.length)];
    }
}

- (NSString *)zhn_subStringFromStr:(NSString *)fromStr toStr:(NSString *)toStr {
    NSRange fromRange = [self rangeOfString:fromStr];
    NSRange toRange = [self rangeOfString:toStr];
    if (fromRange.location == NSNotFound || toRange.location == NSNotFound) {
        return self;
    }else {
        NSRange range = NSMakeRange((fromRange.location + fromRange.length), (toRange.location - (fromRange.location + fromRange.length)));
        return [self substringWithRange:range];
    }
}
@end
