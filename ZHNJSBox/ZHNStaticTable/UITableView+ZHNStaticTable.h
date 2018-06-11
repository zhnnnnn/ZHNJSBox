//
//  UITableView+ZHNStaticTable.h
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNStaticTableSection.h"

@interface UITableView (ZHNStaticTable)

/**
 清空数据
 */
- (void)zhn_clearData;

/**
 添加一组数据 (调用之前需要调用`zhn_initializeEnvironmentWithOriginalDelegate`方法来初始化环境)

 @param sectionHandle 一组数据的具体内容
 */
- (void)zhn_addSection:(void(^)(ZHNStaticTableSection *section))sectionHandle;

/**
 初始化环境 (默认的行高是44，默认的Cell是UITableViewCell。用runtime做了一层转发，内部实现了基础的方法，外部不需要覆写这些方法。)

 @param originalDelegate 原始的代理
 @param originalDatasource 原始的数据源
 */
- (void)zhn_initializeEnvironmentWithOriginalDelegate:(id <UITableViewDelegate>)originalDelegate
                                   originalDatasource:(id <UITableViewDataSource>)originalDatasource;

/**
 初始化环境，以及一些基础的默认数据

 @param defaultRowHeight 默认的行高
 @param defaultCellClass 默认的cell Class
 @param sectionHeader 默认的section头
 @param headerHeight 默认的section头的高度
 @param sectionFooter 默认的section的尾巴
 @param footerHeight 默认的section的尾巴的高度
 @param originalDelegate 原始的代理
 @param originalDatasource 原始的数据源
 */
- (void)zhn_initializeEnvironmentWithDefaultRowHeight:(CGFloat)defaultRowHeight
                                     defaultCellClass:(Class)defaultCellClass
                                 defaultSectionHeader:(ZHNStaticTableSectionHeader)sectionHeader
                                  defaultHeaderHeight:(CGFloat)headerHeight
                                 defaultSectionFooter:(ZHNStaticTableSectionFooter)sectionFooter
                                  defaultFooterHeight:(CGFloat)footerHeight
                                     OriginalDelegate:(id<UITableViewDelegate>)originalDelegate
                                   originalDatasource:(id<UITableViewDataSource>)originalDatasource;
@end
