//
//  ZHNJSEditorTheme.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorTheme.h"
#import "NSString+ZHNJSEditor.h"
#import "UIColor+ZHNHexColor.h"
#import "ZHNJSEditorJSBoxHighlightExt.h"

typedef NS_ENUM(NSInteger,ZHNAttributedType) {
    ZHNAttributedTypeFont,
    ZHNAttributedTypeTextColor,
    ZHNAttributedTypeBackgroundColor
};

static NSString *const KDefaultCssID = @"hljs";
static NSString *const KJSBoxFuncModuleID = @"hljs-built_in";
@interface ZHNJSEditorTheme ()
@property (nonatomic, strong) NSMutableDictionary *cssMapDict;
@property (nonatomic, strong) UIFont *regularFont;// 普通
@property (nonatomic, strong) UIFont *bolderFont;// 加粗
@property (nonatomic, strong) UIFont *italicFont;// 斜体
@property (nonatomic, strong) ZHNJSEditorThemeDesc *desc;
@end

@implementation ZHNJSEditorTheme
#pragma mark - public methods
- (instancetype)initWithThemeDesc:(ZHNJSEditorThemeDesc *)desc {
    if (self = [super init]) {
        self.desc = desc;
        // 初始化字体
        [self _initFonts];
        // 初始化css样式
        NSString *path = [[NSBundle mainBundle] pathForResource:desc.themeName ofType:@"css"];
        NSString *css = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self _themeCssToNative:css];
    }
    return self;
}

- (NSAttributedString *)attributeStringForCode:(NSString *)code cssID:(NSString *)cssID {
    // 富文本attrs
    cssID = cssID ? cssID : KDefaultCssID;
    // 默认的富文本参数
    NSDictionary *defaultAttrs = self.cssMapDict[KDefaultCssID];
    // ID对的富文本参数
    NSDictionary *idAttrs = self.cssMapDict[cssID];
    idAttrs = idAttrs ? idAttrs : defaultAttrs;
    // jsbox额外添加的名字对应的富文本参数
    NSDictionary *builtAttrs = self.cssMapDict[KJSBoxFuncModuleID];
    builtAttrs = builtAttrs ? builtAttrs : defaultAttrs;
    
    NSMutableAttributedString *muAttr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSRegularExpression *regex = JSBoxHighlightExt.highlightKeywordRegex;
    NSArray *results = [regex matchesInString:code options:NSMatchingReportCompletion range:NSMakeRange(0, code.length)];
    if (results.count > 0) {
        __block NSRange lastRange = NSMakeRange(0, 0);
        [results enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL * _Nonnull stop) {
            if (result.range.location != NSNotFound) {
                // 特殊字符之前
                NSRange beforRange = NSMakeRange([self _rangeEndForRange:lastRange], result.range.location - [self _rangeEndForRange:lastRange]);
                NSString *beforStr = [code substringWithRange:beforRange];
                [muAttr appendAttributedString:[[NSAttributedString alloc] initWithString:beforStr attributes:idAttrs]];
                // 特殊字符
                NSString *keyword = [code substringWithRange:result.range];
                [muAttr appendAttributedString:[[NSAttributedString alloc] initWithString:keyword attributes:builtAttrs]];
                // 特殊字符之后,只需要处理最后一个
                if (idx == results.count - 1) {
                    NSRange afterRange = NSMakeRange([self _rangeEndForRange:result.range], code.length - [self _rangeEndForRange:result.range]);
                    NSString *afterStr = [code substringWithRange:afterRange];
                    [muAttr appendAttributedString:[[NSAttributedString alloc] initWithString:afterStr attributes:idAttrs]];
                }
                lastRange = result.range;
            }
        }];
    }else {
        [muAttr appendAttributedString:[[NSAttributedString alloc] initWithString:code attributes:idAttrs]];
    }
    return muAttr;
}

- (UIColor *)currentThemeBackgroundColor {
    UIColor *color = self.cssMapDict[KDefaultCssID][NSBackgroundColorAttributeName];
    return color ? color : [UIColor whiteColor];
}

- (CGFloat)lineNumWidth {
    return [self.regularFont pointSize] * 2;
}

- (NSDictionary *)defaultAttributeStringAttributes {
    return self.cssMapDict[KDefaultCssID];
}

- (BOOL)isShowLineNumber {
    return self.desc.showNumberOfLines;
}
#pragma mark - pravite methods
- (void)_initFonts {
    NSString *fontName = self.desc.fontName;
    CGFloat fontSize = self.desc.fontSize;
    self.regularFont = [UIFont fontWithName:fontName size:fontSize];
    self.regularFont = self.regularFont ? self.regularFont : [UIFont fontWithName:[NSString stringWithFormat:@"%@-Regular",fontName] size:fontSize];
    
    NSString *boderFontName = [NSString stringWithFormat:@"%@-Bold",fontName];
    UIFont *boderFont = [UIFont fontWithName:boderFontName size:fontSize];
    self.bolderFont = boderFont ? boderFont : self.regularFont;
    
    NSString *italicFontName = [NSString stringWithFormat:@"%@-Italic",fontName];
    NSString *obliqueFontName = [NSString stringWithFormat:@"%@-Oblique",fontName];
    UIFont *italicFont = [UIFont fontWithName:italicFontName size:fontSize];
    UIFont *obliqueFont = [UIFont fontWithName:obliqueFontName size:fontSize];
    self.italicFont = italicFont ? italicFont : (obliqueFont ? obliqueFont : self.regularFont);
}

- (void)_themeCssToNative:(NSString *)cssTheme {
    if (!cssTheme) {return;}
    NSRegularExpression *cssRegx = [NSRegularExpression regularExpressionWithPattern:@"(?:(\\.[a-zA-Z0-9\\-_]*(?:[, ]\\.[a-zA-Z0-9\\-_]*)*)\\{([^\\}]*?)\\})" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [cssRegx matchesInString:cssTheme options:NSMatchingReportCompletion range:NSMakeRange(0, cssTheme.length)];
    for (NSTextCheckingResult *result in results) {
        NSString *css = [cssTheme substringWithRange:result.range];
        NSString *propertyStartStr = @"{";
        NSString *propertyEndStr = @"}";
        // id
        NSString *cssIDStr = [css zhn_subStringToStr:propertyStartStr];
        NSArray *cssIDs = [cssIDStr componentsSeparatedByString:@","];
        
        // 属性
        NSString *propertyStr = [css zhn_subStringFromStr:propertyStartStr toStr:propertyEndStr];
        NSArray *propertys = [propertyStr componentsSeparatedByString:@";"];
        NSMutableDictionary *attDict = [NSMutableDictionary dictionary];
        attDict[NSFontAttributeName] = self.regularFont;// 需要设置一个默认的字体
        for (NSString *property in propertys) {
            NSString *name = [property zhn_subStringToStr:@":"];
            NSString *value = [property zhn_subStringFromStr:@":"];
            ZHNAttributedType type = [self _attributedTypeForCssName:name];
            NSString *attrName = [self _attributeNameForType:type];
            NSString *attrValue = [self _attributeValueWithType:type cssValue:value];
            attDict[attrName] = attrValue;
        }
        
        // css的id对应一个attributestring的attribute字典
        [cssIDs enumerateObjectsUsingBlock:^(NSString *cssID, NSUInteger idx, BOOL * _Nonnull stop) {
            cssID = [cssID substringFromIndex:1];
            self.cssMapDict[cssID] = attDict;
        }];
    }
}

- (ZHNAttributedType)_attributedTypeForCssName:(NSString *)cssName {
    if ([cssName isEqualToString:@"color"]) {
        return ZHNAttributedTypeTextColor;
    }
    else if ([cssName isEqualToString:@"font-weight"] || [cssName isEqualToString:@"font-style"]) {
        return ZHNAttributedTypeFont;
    }
    else if ([cssName isEqualToString:@"background-color"] || [cssName isEqualToString:@"background"]) {
        return ZHNAttributedTypeBackgroundColor;
    }
    else {
        return ZHNAttributedTypeFont;
    }
}

- (NSString *)_attributeNameForType:(ZHNAttributedType)type {
    switch (type) {
        case ZHNAttributedTypeFont:
            return NSFontAttributeName;
            break;
        case ZHNAttributedTypeTextColor:
            return NSForegroundColorAttributeName;
            break;
        case ZHNAttributedTypeBackgroundColor:
            return NSBackgroundColorAttributeName;
            break;
        default:
            return NSFontAttributeName;
            break;
    }
}

- (id)_attributeValueWithType:(ZHNAttributedType)type cssValue:(NSString *)cssValue {
    switch (type) {
        case ZHNAttributedTypeFont:
            return [self _cssFontToNative:cssValue];
            break;
        case ZHNAttributedTypeBackgroundColor:
        case ZHNAttributedTypeTextColor:
            return [self _cssColorToNative:cssValue];
            break;
        default:
            return @"";
            break;
    }
}

- (id)_cssFontToNative:(NSString *)cssFont {
    NSArray *boderValues = @[@"bold",@"bolder",@"700",@"800",@"900"];
    NSArray *italicValues = @[@"italic",@"oblique"];
    if ([boderValues containsObject:cssFont]) {
        return self.bolderFont;
    }
    else if ([italicValues containsObject:cssFont]) {
        return self.italicFont;
    }
    else {
        return self.regularFont;
    }
}

- (UIColor *)_cssColorToNative:(NSString *)cssColor {
    if ([cssColor hasPrefix:@"#"]) {
        return [UIColor colorWithHexString:cssColor];
    }
    else if ([cssColor isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }
    else if ([cssColor isEqualToString:@"white"]) {
        return [UIColor whiteColor];
    }
    return [UIColor whiteColor];
}

- (NSInteger)_rangeEndForRange:(NSRange)range {
    return range.location + range.length;
}

#pragma mark - getters
- (NSMutableDictionary *)cssMapDict {
    if (_cssMapDict == nil) {
        _cssMapDict = [NSMutableDictionary dictionary];
    }
    return _cssMapDict;
}
@end
