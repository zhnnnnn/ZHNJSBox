//
//  ZHNJSEditorHighlighter.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorHighlighter.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NSString+ZHNJSEditor.h"
#import "ZHNJSEditorTheme.h"
#import "ZHNJSEditorHTMLUnEscaper.h"

static NSString *const KSpanStartStr = @"span";
static NSString *const KSpanEndStr = @"/span>";
static NSString *const KClassStartStr = @"class=\"";
static NSString *const KClassEndStr = @"\">";

@interface ZHNJSEditorHighlighter ()
@property (nonatomic, strong) JSContext *context;
@end

@implementation ZHNJSEditorHighlighter
- (instancetype)initWithTheme:(ZHNJSEditorTheme *)theme {
    if (self = [super init]) {
        _theme = theme;
    }
    return self;
}

+ (instancetype)highlighterdeWithfaultTheme {
    ZHNJSEditorThemeDesc *desc = [ZHNJSEditorThemeDesc defaultDesc];
    ZHNJSEditorTheme *theme = [[ZHNJSEditorTheme alloc] initWithThemeDesc:desc];
    return [[self alloc] initWithTheme:theme];
}

+ (instancetype)highlighterWithCustomThemeDesc:(ZHNJSEditorThemeDesc *(^)(void))desc{
    ZHNJSEditorTheme *theme = [[ZHNJSEditorTheme alloc] initWithThemeDesc:desc()];
    return [[self alloc] initWithTheme:theme];
}

- (void)reloadThemeWithDesc:(ZHNJSEditorThemeDesc *(^)(void))desc {
    ZHNJSEditorTheme *theme = [[ZHNJSEditorTheme alloc] initWithThemeDesc:desc()];
    _theme = theme;
}

- (NSAttributedString *)highlightCode:(NSString *)code language:(NSString *)language {
    code = [self _fixCode:code];
    NSString *script;
    if (language) {
        script = [NSString stringWithFormat:@"window.hljs.highlight(\"%@\",\"%@\").value;",language,code];
    }else {
        script = [NSString stringWithFormat:@"window.hljs.highlightAuto(\"%@\").value;",code];
    }
    NSString *highlightStr = [[self.context evaluateScript:script] toString];
    return [self _highlightHTMLToNativeAttributedString:highlightStr];
}

- (NSAttributedString *)highlightJSCode:(NSString *)jsCode {
    return [self highlightCode:jsCode language:@"javascript"];
}

#pragma mark - pravite methods
- (NSString *)_fixCode:(NSString *)code {
    code = [code stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    code = [code stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
    code = [code stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    code = [code stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    code = [code stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return code;
}

- (NSAttributedString *)_highlightHTMLToNativeAttributedString:(NSString *)highlightHtml {
    NSMutableAttributedString *codeAttrStr = [[NSMutableAttributedString alloc]initWithString:@""];
    NSScanner *scann = [NSScanner scannerWithString:highlightHtml];
    NSMutableArray *spanIDs = [NSMutableArray array];
    NSString *resultStr = @"";
    NSInteger maxScanIndex = 0;
    while (!scann.isAtEnd) {
        BOOL scanResult = [scann scanUpToString:@"<" intoString:&resultStr];
        if (scanResult) {
            if (scann.isAtEnd) {
                // 处理剩余匹配不到代码
                NSString *residueCode = @"";
                if ([highlightHtml containsString:KSpanEndStr]) {
                    maxScanIndex = maxScanIndex + KSpanEndStr.length;
                    residueCode = [highlightHtml substringFromIndex:maxScanIndex];
                }else {
                    residueCode = highlightHtml;
                }

                NSAttributedString *attrStr = [self.theme attributeStringForCode:residueCode cssID:nil];
                [codeAttrStr appendAttributedString:attrStr];
                continue;
            }
        }
        scann.scanLocation++;
        maxScanIndex = scann.scanLocation;
        
        // 解析代码对应的高亮显示
        NSString *code;
        NSString *spanID;
        NSString *nexChar = [highlightHtml substringWithRange:NSMakeRange(scann.scanLocation, 1)];
        if ([resultStr hasPrefix:KSpanStartStr]) {
            code = [resultStr zhn_subStringFromStr:KClassEndStr];
            spanID = [resultStr zhn_subStringFromStr:KClassStartStr toStr:KClassEndStr];

            // 处理嵌套
            if ([nexChar isEqualToString:@"s"]) {
                [spanIDs addObject:spanID];
            }
        }
        else if ([resultStr containsString:KSpanEndStr]) {
            code = [resultStr zhn_subStringFromStr:KSpanEndStr];
            spanID = [spanIDs lastObject];
            
            // 处理嵌套
            if ([nexChar isEqualToString:@"/"]) {
                [spanIDs removeLastObject];
            }
        }
        else {
            code = resultStr;
        }
        
        // html转义符处理
        NSRegularExpression *htmlEscape = [NSRegularExpression regularExpressionWithPattern:@"&#?[a-zA-Z0-9]+?;" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *escaps = [htmlEscape matchesInString:code options:NSMatchingReportCompletion range:NSMakeRange(0, code.length)];
        NSInteger offset = 0;
        for (NSTextCheckingResult *escap in escaps) {
            if (escap.range.location != NSNotFound) {
                NSRange fixedRange = NSMakeRange(escap.range.location - offset, escap.range.length);
                NSString *unEscap = [code substringWithRange:escap.range];
                if (unEscap) {
                    unEscap = [ZHNJSEditorHTMLUnEscaper unEscaperCode:unEscap];
                    if (!unEscap) {
                        continue;
                    }
                    code = [code stringByReplacingCharactersInRange:fixedRange withString:unEscap];
                    offset += escap.range.length - 1;
                }
            }
        }
        // 获取当前的代码块对应的显示富文本
        NSAttributedString *attStr = [self.theme attributeStringForCode:code cssID:spanID];
        // 拼接富文本
        [codeAttrStr appendAttributedString:attStr];
    }
    return codeAttrStr;
}

#pragma mark - getters
- (JSContext *)context {
    if (_context == nil) {
        _context = [[JSContext alloc]init];
        [_context evaluateScript:@"var window = {};"];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"highlight" ofType:@"js"];
        NSString *highlightJS = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_context evaluateScript:highlightJS];
        
        // 加载语言配置
        NSString *swiftPath = [[NSBundle mainBundle]pathForResource:@"javascript.min" ofType:@"js"];
        NSString *swiftJS = [NSString stringWithContentsOfFile:swiftPath encoding:NSUTF8StringEncoding error:nil];
        [_context evaluateScript:swiftJS];
    }
    return _context;
}
@end
