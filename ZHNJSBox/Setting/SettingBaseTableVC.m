//
//  ThemeSettingTableVC.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "SettingBaseTableVC.h"
#import "SettingCell.h"

@interface SettingBaseTableVC ()
@property (nonatomic, strong) SettingCell *oldSelectCell;
@end

@implementation SettingBaseTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.defaultDesc = [ZHNJSEditorThemeDesc defaultDesc];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [SettingCell createCellWithTableView:tableView];
    cell.title = self.titles[indexPath.row];
    if ([cell.title isEqualToString:self.judgeProperty]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.oldSelectCell = cell;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self reloadTheme:self.defaultDesc selectTitle:self.titles[indexPath.row]];
    
    self.oldSelectCell.accessoryType = UITableViewCellAccessoryNone;
    SettingCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.oldSelectCell = selectCell;
}

@end
