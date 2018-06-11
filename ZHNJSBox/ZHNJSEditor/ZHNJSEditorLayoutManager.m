//
//  ZHNJSEditorLayoutManager.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/4.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorLayoutManager.h"
#import "ZHNJSEditorTextStorage.h"

@interface ZHNJSEditorLayoutManager ()
@property (nonatomic, assign) NSInteger lastLocation;
@property (nonatomic) NSUInteger lastParaLocation;
@property (nonatomic) NSUInteger lastParaNumber;
@end

@implementation ZHNJSEditorLayoutManager
- (instancetype)init {
    if (self = [super init]) {
        self.lastParaNumber = 0;
        self.lastParaLocation = 0;
    }
    return self;
}


// 判断方法参考自 https://github.com/alldritt/TextKit_LineNumbers
// 删除时候的操作
- (void)processEditingForTextStorage:(NSTextStorage *)textStorage edited:(NSTextStorageEditActions)editMask range:(NSRange)newCharRange changeInLength:(NSInteger)delta invalidatedRange:(NSRange)invalidatedCharRange
{
    [super processEditingForTextStorage:textStorage edited:editMask range:newCharRange changeInLength:delta invalidatedRange:invalidatedCharRange];
    
    if (invalidatedCharRange.location < self.lastParaLocation)
    {
        //  When the backing store is edited ahead the cached paragraph location, invalidate the cache and force a complete
        //  recalculation.  We cannot be much smarter than this because we don't know how many paragraphs have been deleted
        //  since the text has already been removed from the backing store.
        self.lastParaLocation = 0;
        self.lastParaNumber = 0;
    }
}

// 因为drawBackgroundForGlyphRange这个方法里是不能简单可以连续取值的，这个方法的逻辑是先存一下之前range的location，然后下次需要获取某个行range对应行号的时候需要拿到当前的location到存的location之间的所有的行然后做计算。这样拿到的行号才是正确的。
- (NSUInteger) _paraNumberForRange:(NSRange) charRange {
    //  NSString does not provide a means of efficiently determining the paragraph number of a range of text.  This code
    //  attempts to optimize what would normally be a series linear searches by keeping track of the last paragraph number
    //  found and uses that as the starting point for next paragraph number search.  This works (mostly) because we
    //  are generally asked for continguous increasing sequences of paragraph numbers.  Also, this code is called in the
    //  course of drawing a pagefull of text, and so even when moving back, the number of paragraphs to search for is
    //  relativly low, even in really long bodies of text.
    //
    //  This all falls down when the user edits the text, and can potentially invalidate the cached paragraph number which
    //  causes a (potentially lengthy) search from the beginning of the string.
    
    if (charRange.location == self.lastParaLocation)
        return self.lastParaNumber;
    else if (charRange.location < self.lastParaLocation) {
        //  We need to look backwards from the last known paragraph for the new paragraph range.  This generally happens
        //  when the text in the UITextView scrolls downward, revaling paragraphs before/above the ones previously drawn.
        
        NSString* s = self.textStorage.string;
        __block NSUInteger paraNumber = self.lastParaNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(charRange.location, self.lastParaLocation - charRange.location)
                              options:NSStringEnumerationByParagraphs |
         NSStringEnumerationSubstringNotRequired |
         NSStringEnumerationReverse
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location <= charRange.location) {
                                   *stop = YES;
                               }
                               --paraNumber;
                           }];
        
        self.lastParaLocation = charRange.location;
        self.lastParaNumber = paraNumber;
        return paraNumber;
    }
    else {
        //  We need to look forward from the last known paragraph for the new paragraph range.  This generally happens
        //  when the text in the UITextView scrolls upwards, revealing paragraphs that follow the ones previously drawn.
        
        NSString* s = self.textStorage.string;
        __block NSUInteger paraNumber = self.lastParaNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(self.lastParaLocation, charRange.location - self.lastParaLocation)
                              options:NSStringEnumerationByParagraphs | NSStringEnumerationSubstringNotRequired
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location >= charRange.location) {
                                   *stop = YES;
                               }
                               ++paraNumber;
                           }];
        
        self.lastParaLocation = charRange.location;
        self.lastParaNumber = paraNumber;
        return paraNumber;
    }
}

- (void)drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin {
    [super drawBackgroundForGlyphRange:glyphsToShow atPoint:origin];
    BOOL showlineNumber = [(ZHNJSEditorTextStorage *)self.textStorage isShowLineNumber];
    if (showlineNumber) {
        CGFloat lineNumWidth = [(ZHNJSEditorTextStorage *)self.textStorage lineNumWidth];
        NSDictionary *attrs = [(ZHNJSEditorTextStorage *)self.textStorage defaultAttributeStringAttributes];
        [self enumerateLineFragmentsForGlyphRange:glyphsToShow usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
            // 段落range glyphRange是行的range
            NSRange paraRange = [self.textStorage.string paragraphRangeForRange:glyphRange];
            NSRange charRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:nil];
            if (paraRange.location == charRange.location) {// 只画新的一行的开始
                NSString *lineStr = [NSString stringWithFormat:@"%ld",[self _paraNumberForRange:charRange]];
                CGSize size = [lineStr sizeWithAttributes:attrs];
                CGRect drawRect = CGRectMake(lineNumWidth - size.width - 2, rect.origin.y, lineNumWidth, rect.size.height);
                [lineStr drawInRect:drawRect withAttributes:attrs];
            }
        }];
    }
}
@end
