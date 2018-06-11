//
//  ZHNJSEditorTextStorage.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/4.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorTextStorage.h"
#import "ZHNJSEditorHighlighter.h"

@interface ZHNJSEditorTextStorage ()
@property (nonatomic, strong) NSTextStorage *basicStorage;
@property (nonatomic, strong) ZHNJSEditorHighlighter *highlighter;
@end

@implementation ZHNJSEditorTextStorage
- (instancetype)init {
    if (self = [super init]) {
        self.basicStorage = [[NSTextStorage alloc] init];
        self.highlighter = [ZHNJSEditorHighlighter highlighterdeWithfaultTheme];
    }
    return self;
}

#pragma mark - 必须要实现的方法
- (NSString *)string {
    return self.basicStorage.string;
}

- (NSDictionary<NSAttributedStringKey,id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.basicStorage attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self.basicStorage replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attrs range:(NSRange)range {
    [self.basicStorage setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

- (void)processEditing {
    [super processEditing];
    if (self.editedMask != 1) {
        NSRange range = [self.string paragraphRangeForRange:self.editedRange];
        NSString *line = [self.string substringWithRange:range];
        NSAttributedString *attrLine = [self.highlighter highlightJSCode:line];
        [attrLine enumerateAttributesInRange:NSMakeRange(0, attrLine.length) options:@[] usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange locRange, BOOL * _Nonnull stop) {
            NSRange fixRange = NSMakeRange(range.location+locRange.location, locRange.length);
            fixRange.length = (fixRange.location + fixRange.length < self.string.length) ? fixRange.length : self.string.length-fixRange.location;
            fixRange.length = (fixRange.length > 0) ? fixRange.length : 0;
            [self setAttributes:attrs range:fixRange];
        }];
    }
}

#pragma mark - getters
- (UIColor *)themeBackgroundColor {
    return self.highlighter.theme.currentThemeBackgroundColor;
}

- (CGFloat)lineNumWidth {
    return self.highlighter.theme.lineNumWidth;
}

- (NSDictionary *)defaultAttributeStringAttributes {
    return self.highlighter.theme.defaultAttributeStringAttributes;
}

- (BOOL)isShowLineNumber {
    return [self.highlighter.theme isShowLineNumber];
}

@end
