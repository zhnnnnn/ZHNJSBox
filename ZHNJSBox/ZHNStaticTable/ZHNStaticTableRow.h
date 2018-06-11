//
//  ZHNStaticTableRow.h
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ZHNRowDisplayCellHandle)(UITableView *tableView,id cell,NSIndexPath *indexPath);
typedef void(^ZHNRowSelectCellHandle)(UITableView *tableView,NSIndexPath *indexPath);
@interface ZHNStaticTableRow : NSObject
/**
 当前cell的class
 */
@property (nonatomic,assign) Class cellClass;

/**
 当前的行高
 */
@property (nonatomic,assign) CGFloat rowHeight;

/**
 cell的数据展示
 */
@property (nonatomic,copy) ZHNRowDisplayCellHandle displayCellHandle;

/**
 cell的点击
 */
@property (nonatomic,copy) ZHNRowSelectCellHandle selectCellHandle;
@end
