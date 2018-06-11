//
//  ZHNJSEditorTextView.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/4.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorTextView.h"
#import "ZHNJSEditorTextStorage.h"

@implementation ZHNJSEditorTextView
- (void)drawRect:(CGRect)rect {
    BOOL showNumLine = [(ZHNJSEditorTextStorage *)self.textStorage isShowLineNumber];
    if (showNumLine) {
        CGFloat width = [(ZHNJSEditorTextStorage *)self.textStorage lineNumWidth];
        UIColor *defaultColor = [(ZHNJSEditorTextStorage *)self.textStorage themeBackgroundColor];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat height = self.contentSize.height;
        // 画框
        CGContextSetFillColorWithColor(context, defaultColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, width, height));
        // 画线
        CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
        CGContextFillRect(context, CGRectMake(width, 0, 0.5, height));
    }

    [super drawRect:rect];
}

@end
