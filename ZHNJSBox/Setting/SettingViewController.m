//
//  SettingViewController.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "SettingViewController.h"
#import "UITableView+ZHNStaticTable.h"
#import "SettingCell.h"
#import "ThemeSettingTableVC.h"
#import "FontNameSettingVC.h"
#import "FontSizeSettingTableVC.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"设置";
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    [self _setupData];
}

- (void)_setupData {
    __weak typeof(self) weakSelf = self;
    [self.tableView zhn_addSection:^(ZHNStaticTableSection *section) {
        [section zhn_addRow:^(ZHNStaticTableRow *row) {
            row.displayCellHandle = ^(UITableView *tableView, SettingCell *cell, NSIndexPath *indexPath) {
                cell.title = @"主题";
            };
            row.selectCellHandle = ^(UITableView *tableView, NSIndexPath *indexPath) {
                [weakSelf.navigationController pushViewController:[[ThemeSettingTableVC alloc] init] animated:YES];
            };
        }];
        [section zhn_addRow:^(ZHNStaticTableRow *row) {
            row.displayCellHandle = ^(UITableView *tableView, SettingCell *cell, NSIndexPath *indexPath) {
                cell.title = @"字体";
            };
            row.selectCellHandle = ^(UITableView *tableView, NSIndexPath *indexPath) {
                [weakSelf.navigationController pushViewController:[[FontNameSettingVC alloc] init] animated:YES];
            };
        }];
        [section zhn_addRow:^(ZHNStaticTableRow *row) {
            row.displayCellHandle = ^(UITableView *tableView, SettingCell *cell, NSIndexPath *indexPath) {
                cell.title = @"字号";
            };
            row.selectCellHandle = ^(UITableView *tableView, NSIndexPath *indexPath) {
                [weakSelf.navigationController pushViewController:[[FontSizeSettingTableVC alloc] init] animated:YES];
            };
        }];
    }];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        [_tableView zhn_initializeEnvironmentWithDefaultRowHeight:44 defaultCellClass:[SettingCell class] defaultSectionHeader:nil defaultHeaderHeight:0 defaultSectionFooter:nil defaultFooterHeight:0 OriginalDelegate:self originalDatasource:self];
    }
    return _tableView;
}

@end
