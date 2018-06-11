//
//  ZHNJSEditorTextStorage.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/4.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHNJSEditorTextStorage : NSTextStorage
- (UIColor *)themeBackgroundColor;

- (CGFloat)lineNumWidth;

- (NSDictionary *)defaultAttributeStringAttributes;

- (BOOL)isShowLineNumber;
@end
