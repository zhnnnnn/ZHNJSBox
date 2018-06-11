//
//  ZHNJSEditorHTMLUnEscaper.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/31.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorHTMLUnEscaper.h"

@implementation ZHNJSEditorHTMLUnEscaper
+ (NSString *)unEscaperCode:(NSString *)code {
    NSDictionary *dict = @{@"&quot;" : @"\"",
                           @"&amp;"  : @"&",
                           @"&apos;" : @"'",
                           @"&lt;"   : @"<",
                           @"&gt;"   : @">",};
    
    // TODO 添加其他字符
    
    return dict[code];
}
@end
