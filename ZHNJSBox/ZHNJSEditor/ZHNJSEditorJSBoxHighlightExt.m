//
//  ZHNJSEditorJSBoxHighlightExt.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/2.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorJSBoxHighlightExt.h"

@interface ZHNJSEditorJSBoxHighlightExt ()
@property (nonatomic, copy) NSString *extKeywordsString;
@end

@implementation ZHNJSEditorJSBoxHighlightExt
- (instancetype)init {
    if (self = [super init]) {
        _extKeywordsString = @"$addin|$align|$app|$archiver|$assetMedia|$audio|$browser|$btnType|$cache|$calendar|$cellInset|$clipboard|$color|$console|$contact|$contentMode|$context|$data|$define|$delay|$detector|$device|$drive|$env|$file|$font|$http|$icon|$imagePicker|$include|$indexPath|$input|$insets|$kbType|$keyboard|$l10n|$labeledValue|$layout|$lineCap|$lineJoin|$location|$mediaType|$message|$motion|$network|$objc|$objc_release|$objc_retain|$pageSize|$pdf|$photo|$picker|$point|$props|$protocol|$push|$qrcode|$quicklook|$range|$rect|$reminder|$rgb|$rgba|$safari|$share|$size|$ssh|$system|$text|$thread|$timer|$transform|$ui|$zero";
        _extHighlightKeywords = [_extKeywordsString componentsSeparatedByString:@"|"];
        _extHighlightKeywords = [_extKeywordsString componentsSeparatedByString:@"|"];
        NSString *fixedKeywordStr = [_extKeywordsString stringByReplacingOccurrencesOfString:@"$" withString:@"\\$"];
        NSString *pattern = [NSString stringWithFormat:@"((?<=(\\s|\\n))(%@)(?![A-Za-z0-9])|(%@)(?![A-Za-z0-9]))",fixedKeywordStr,fixedKeywordStr];
        _highlightKeywordRegex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    }
    return self;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ZHNJSEditorJSBoxHighlightExt *ext = nil;
    dispatch_once(&onceToken, ^{
        ext = [[ZHNJSEditorJSBoxHighlightExt alloc]init];
    });
    return ext;
}
@end
