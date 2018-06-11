//
//  ZHNStaticTableDataManager.m
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNStaticTableDataManager.h"

@implementation ZHNStaticTableDataManager
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZHNStaticTableSection *stSection = self.sections[section];
    return stSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHNStaticTableSection *stSection = self.sections[indexPath.section];
    ZHNStaticTableRow *row = stSection.rows[indexPath.row];
    if (!row.cellClass) {
        row.cellClass = self.defaultCellClass;
    }
    NSAssert(![row.cellClass isKindOfClass:[UITableViewCell class]], @"cellClass需要是UITableViewCell的子类");
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@_reuse",NSStringFromClass(row.cellClass)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [(UITableViewCell *)[row.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    if (row.displayCellHandle) {
        row.displayCellHandle(tableView,cell,indexPath);
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHNStaticTableSection *stSection = self.sections[indexPath.section];
    ZHNStaticTableRow *row = stSection.rows[indexPath.row];
    if (row.rowHeight <= 0) {
        return self.defaultRowHeight;
    }else {
       return row.rowHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZHNStaticTableSection *stSection = self.sections[indexPath.section];
    ZHNStaticTableRow *row = stSection.rows[indexPath.row];
    if (row.selectCellHandle) {
        row.selectCellHandle(tableView, indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZHNStaticTableSection *stSection = self.sections[section];
    ZHNStaticTableSectionHeader header = stSection.header ? stSection.header : self.sectionHeader;
    if (header) {
        return header(section);
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZHNStaticTableSection *stSection = self.sections[section];
    CGFloat headerHeight = stSection.headerHeight <= 0 ? self.defaultHeaderHeight : stSection.headerHeight;
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ZHNStaticTableSection *stSection = self.sections[section];
    ZHNStaticTableSectionHeader footer = stSection.footer ? stSection.footer : self.sectionFooter;
    if (footer) {
        return footer(section);
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZHNStaticTableSection *stSection = self.sections[section];
    CGFloat footerHeight = stSection.footerHeight <= 0 ? self.defaultFooterHeight : stSection.footerHeight;
    return footerHeight;
}
@end
