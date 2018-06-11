//
//  NSString+ZHNJSEditor.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/31.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZHNJSEditor)
- (NSString *)zhn_subStringToStr:(NSString *)str;
- (NSString *)zhn_subStringFromStr:(NSString *)str;
- (NSString *)zhn_subStringFromStr:(NSString *)fromStr toStr:(NSString *)toStr;
@end
