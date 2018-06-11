//
//  ZHNJSEditorHighlighter.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHNJSEditorTheme.h"
#import "ZHNJSEditorThemeDesc.h"

@interface ZHNJSEditorHighlighter : NSObject
// 初始化方法
- (instancetype)initWithTheme:(ZHNJSEditorTheme *)theme;
+ (instancetype)highlighterdeWithfaultTheme;
+ (instancetype)highlighterWithCustomThemeDesc:(ZHNJSEditorThemeDesc *(^)(void))desc;

/**
 当前的主题
 */
@property (nonatomic, strong,readonly) ZHNJSEditorTheme *theme;

/**
 刷新主题

 @param desc 主题描述
 */
- (void)reloadThemeWithDesc:(ZHNJSEditorThemeDesc *(^)(void))desc;

/**
 高亮代码块

 @param code 代码
 @param language 语言
 @return 富文本
 */
- (NSAttributedString *)highlightCode:(NSString *)code language:(NSString *)language;

/**
 高亮js代码

 @param jsCode js代码
 @return 富文本
 */
- (NSAttributedString *)highlightJSCode:(NSString *)jsCode;
@end
