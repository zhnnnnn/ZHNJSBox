//
//  ZHNJSEditorJSBoxHighlightExt.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/2.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
// 自定义highlight.js尝试了下找不到支持$字符的方式，暂时用原生来处理
#define JSBoxHighlightExt [ZHNJSEditorJSBoxHighlightExt shareInstance]
@interface ZHNJSEditorJSBoxHighlightExt : NSObject
+ (instancetype)shareInstance;
/**
 JSBox 对应的需要额外高亮的关键字
 */
@property (nonatomic, copy, readonly) NSArray *extHighlightKeywords;

/**
 JSBox 对应的需要额外高亮的关键字的正则
 */
@property (nonatomic, strong, readonly) NSRegularExpression *highlightKeywordRegex;
@end
