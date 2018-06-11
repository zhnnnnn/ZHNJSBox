//
//  ZHNStaticTableDataManager.h
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHNStaticTableSection.h"
#import "ZHNStaticTableRow.h"

@interface ZHNStaticTableDataManager : NSObject <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) CGFloat defaultRowHeight;
@property (nonatomic,assign) Class defaultCellClass;

@property (nonatomic,assign) CGFloat defaultHeaderHeight;
@property (nonatomic,copy) ZHNStaticTableSectionHeader sectionHeader;

@property (nonatomic,assign) CGFloat defaultFooterHeight;
@property (nonatomic,copy) ZHNStaticTableSectionFooter sectionFooter;

@property (nonatomic,strong) NSArray <ZHNStaticTableSection *> *sections;
@end
