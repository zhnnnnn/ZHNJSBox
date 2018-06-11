//
//  UITableView+ZHNStaticTable.m
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UITableView+ZHNStaticTable.h"
#import <objc/runtime.h>
#import "ZHNStaticTableDataManager.h"
#import "ZHNDelegateContainer.h"
#import "ZHNStaticTableDataManager.h"

@interface UITableView()
@property (nonatomic,strong) ZHNStaticTableDataManager *dataManager;
@property (nonatomic,strong) ZHNDelegateContainer *dataSourceContainer;
@property (nonatomic,strong) ZHNDelegateContainer *delegateContainer;
@end

@implementation UITableView (ZHNStaticTable)
#pragma mark - public methods
- (void)zhn_clearData {
    [self.sections removeAllObjects];
}

- (void)zhn_addSection:(void (^)(ZHNStaticTableSection *))sectionHandle {
    ZHNStaticTableSection *section = [[ZHNStaticTableSection alloc]init];
    sectionHandle(section);
    [self.sections addObject:section];
    self.dataManager.sections = self.sections;
}

- (void)zhn_initializeEnvironmentWithDefaultRowHeight:(CGFloat)defaultRowHeight defaultCellClass:(Class)defaultCellClass defaultSectionHeader:(ZHNStaticTableSectionHeader)sectionHeader defaultHeaderHeight:(CGFloat)headerHeight defaultSectionFooter:(ZHNStaticTableSectionFooter)sectionFooter defaultFooterHeight:(CGFloat)footerHeight OriginalDelegate:(id<UITableViewDelegate>)originalDelegate originalDatasource:(id<UITableViewDataSource>)originalDatasource {
    // 防止外部覆写主要的方法
    NSAssert(![originalDatasource respondsToSelector:@selector(numberOfSectionsInTableView:)], @"- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;staticTable内部已经实现该方法，外部的originalDatasource不能覆写此方法。");
    NSAssert(![originalDatasource respondsToSelector:@selector(tableView:numberOfRowsInSection:)], @"- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;staticTable内部已经实现该方法，外部的originalDatasource不能覆写此方法。");
    NSAssert(![originalDatasource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)], @"- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;staticTable内部已经实现该方法，外部的originalDatasource不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)], @"- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)], @"- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)], @"- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)], @"- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)], @"- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    NSAssert(![originalDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)], @"- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;staticTable内部已经实现该方法，外部的originalDelegate不能覆写此方法。");
    
    // default
    self.dataManager.defaultCellClass = defaultCellClass;
    self.dataManager.defaultRowHeight = defaultRowHeight;
    self.dataManager.defaultFooterHeight = footerHeight;
    self.dataManager.defaultHeaderHeight = headerHeight;
    self.dataManager.sectionFooter = sectionFooter;
    self.dataManager.sectionHeader = sectionHeader;
    
    // delegate
    ZHNDelegateContainer *delegateContainer = [ZHNDelegateContainer zhn_containerWithDelegates:@[self.dataManager,originalDelegate]];
    self.delegate = (id)delegateContainer;
    self.delegateContainer = delegateContainer;
    
    // datasource
    ZHNDelegateContainer *dataSourceContainer = [ZHNDelegateContainer zhn_containerWithDelegates:@[self.dataManager,originalDatasource]];
    self.dataSource = (id)dataSourceContainer;
    self.dataSourceContainer = dataSourceContainer;
    
    // 默认的分割线处理
    self.tableFooterView = [[UIView alloc]init];
}

- (void)zhn_initializeEnvironmentWithOriginalDelegate:(id<UITableViewDelegate>)originalDelegate originalDatasource:(id<UITableViewDataSource>)originalDatasource {
    [self zhn_initializeEnvironmentWithDefaultRowHeight:44 defaultCellClass:[UITableViewCell class] defaultSectionHeader:nil defaultHeaderHeight:0 defaultSectionFooter:nil defaultFooterHeight:0 OriginalDelegate:originalDelegate originalDatasource:originalDatasource];
}

#pragma mark - gettters
- (ZHNStaticTableDataManager *)dataManager {
    ZHNStaticTableDataManager *dataManager = objc_getAssociatedObject(self, _cmd);
    if (!dataManager) {
        dataManager = [[ZHNStaticTableDataManager alloc]init];
        objc_setAssociatedObject(self, _cmd, dataManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dataManager;
}

- (ZHNDelegateContainer *)delegateContainer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDelegateContainer:(ZHNDelegateContainer *)delegateContainer {
    objc_setAssociatedObject(self, @selector(delegateContainer), delegateContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ZHNDelegateContainer *)dataSourceContainer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDataSourceContainer:(ZHNDelegateContainer *)dataSourceContainer {
    objc_setAssociatedObject(self, @selector(dataSourceContainer), dataSourceContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)sections {
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
@end
