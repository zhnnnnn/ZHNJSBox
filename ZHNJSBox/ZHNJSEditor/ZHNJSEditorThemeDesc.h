//
//  ZHNJSEditorThemeDesc.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/1.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHNJSEditorThemeDesc : NSObject <NSCoding>
@property (nonatomic, assign) CGFloat fontSize;// 字体大小
@property (nonatomic, copy) NSString *fontName;// 字体名字
@property (nonatomic, copy) NSString *themeName;// 主题名字
@property (nonatomic, assign) BOOL showNumberOfLines;// 显示行号

/**
 初始化主题描述

 @param fontSize 主题字体大小
 @param fontName 主题字体名字
 @param themeName 主题名字
 @param showNumberOfLines 显示行号
 @return 主题描述
 */
+ (instancetype)descWithFontSize:(CGFloat)fontSize fontName:(NSString *)fontName themeName:(NSString *)themeName showNumberOfLines:(BOOL)showNumberOfLines;

/**
 默认的主题描述

 @return 主题描述
 */
+ (ZHNJSEditorThemeDesc *)defaultDesc;

/**
 刷新默认的主题描述

 @param desc 主题描述
 */
+ (void)reloadDefaultDesc:(ZHNJSEditorThemeDesc *)desc;

/**
 可选的字体名字数组
 
 @return 字体名字数组
 */
+ (NSArray <NSString *> *)availableFontNames;

/**
 可选的主题名字数组
 
 @return 主题名字数组
 */
+ (NSArray <NSString *> *)availableThemeNames;
@end
