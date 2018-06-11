//
//  ZHNJSEditorTheme.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHNJSEditorThemeDesc.h"

@interface ZHNJSEditorTheme : NSObject
/**
 初始化主题

 @param desc 主题数据抽象对象
 @return 主题对象
 */
- (instancetype)initWithThemeDesc:(ZHNJSEditorThemeDesc *)desc;

/**
 高亮代码

 @param code 需要高亮的代码
 @param cssID 高亮的代码对应的highlight.js的里的span的id
 @return 富文本
 */
- (NSAttributedString *)attributeStringForCode:(NSString *)code cssID:(NSString *)cssID;

/**
 当前主题的背景色

 @return 背景色
 */
- (UIColor *)currentThemeBackgroundColor;

/**
 行号宽度

 @return 宽度
 */
- (CGFloat)lineNumWidth;

/**
 默认的富文本参数

 @return 参数
 */
- (NSDictionary *)defaultAttributeStringAttributes;

/**
 是否显示行号

 @return 显示
 */
- (BOOL)isShowLineNumber;
@end
