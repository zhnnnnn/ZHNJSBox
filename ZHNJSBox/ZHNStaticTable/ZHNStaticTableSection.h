//
//  ZHNStaticTableSection.h
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHNStaticTableRow.h"

typedef UIView *(^ZHNStaticTableSectionHeader)(NSInteger section);
typedef UIView *(^ZHNStaticTableSectionFooter)(NSInteger section);
@interface ZHNStaticTableSection : NSObject
/**
 section的头部高度
 */
@property (nonatomic,assign) CGFloat headerHeight;
/**
 section的尾部的高度
 */
@property (nonatomic,assign) CGFloat footerHeight;
/**
 section的头部
 */
@property (nonatomic,copy) ZHNStaticTableSectionHeader header;
/**
 section的尾部
 */
@property (nonatomic,copy) ZHNStaticTableSectionFooter footer;
/**
 添加一行

 @param rowHandle 一行的具体数据
 */
- (void)zhn_addRow:(void(^)(ZHNStaticTableRow *row))rowHandle;
/**
 添加的行数据的数组
 */
@property (nonatomic,strong) NSMutableArray <ZHNStaticTableRow *> *rows;
@end
