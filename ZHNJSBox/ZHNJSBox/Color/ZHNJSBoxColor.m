//
//  ZHNJSBoxColor.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/9.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxColor.h"
#import "UIColor+ZHNHexColor.h"

@implementation ZHNJSBoxColor
+ (UIColor *)colorWithColorString:(NSString *)color {
    if ([color hasPrefix:@"#"]) {
        return [UIColor colorWithHexString:color];
    }else {
        color = [NSString stringWithFormat:@"%@Color",color];
        return [UIColor performSelector:NSSelectorFromString(color)];
    }
}
@end
