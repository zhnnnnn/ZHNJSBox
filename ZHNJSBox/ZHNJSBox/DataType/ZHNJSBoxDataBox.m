//
//  ZHNJSBoxDataType.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/9.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxDataBox.h"
#define JudgeArgsCount(args,type,argsCount)\
if (args.count != argsCount) {\
    NSLog(@"%@需要传递%d个参数",type,argsCount);\
}\

#define ZHNfloat(arg) [arg floatValue]
@implementation ZHNJSBoxDataBox
+ (id)dataWithDataArgs:(NSArray *)args dataType:(NSString *)dataType {
    if ([dataType isEqualToString:@"size"]) {
        JudgeArgsCount(args, @"size", 2);
        return @(CGSizeMake(ZHNfloat(args[0]), ZHNfloat(args[1])));
    }
    if ([dataType isEqualToString:@"rect"]) {
        JudgeArgsCount(args, @"rect", 4);
        return @(CGRectMake(ZHNfloat(args[0]), ZHNfloat(args[1]), ZHNfloat(args[2]), ZHNfloat(args[3])));
    }
    if ([dataType isEqualToString:@"insets"]) {
        JudgeArgsCount(args, @"insets", 4);
        return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(ZHNfloat(args[0]), ZHNfloat(args[1]), ZHNfloat(args[2]), ZHNfloat(args[3]))];
    }
    if ([dataType isEqualToString:@"point"]) {
        JudgeArgsCount(args, @"point", 2);
        return @(CGPointMake(ZHNfloat(args[0]), ZHNfloat(args[1])));
    }
    if ([dataType isEqualToString:@"range"]) {
        JudgeArgsCount(args, @"range", 2);
        return [NSValue valueWithRange:NSMakeRange(ZHNfloat(args[0]), ZHNfloat(args[1]))];
    }
    return nil;
}
@end
