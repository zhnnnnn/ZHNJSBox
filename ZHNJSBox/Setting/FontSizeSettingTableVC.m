//
//  FontSizeSettingTableVC.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "FontSizeSettingTableVC.h"

@interface FontSizeSettingTableVC ()

@end

@implementation FontSizeSettingTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *titles = [NSMutableArray array];
    for (int index = 8; index < 33; index++) {
        [titles addObject:[NSString stringWithFormat:@"%d",index]];
    }
    self.titles = titles;
    [self.tableView reloadData];
}

- (NSString *)judgeProperty {
    return [NSString stringWithFormat:@"%.0f",self.defaultDesc.fontSize];
}

- (void)reloadTheme:(ZHNJSEditorThemeDesc *)defaultDesc selectTitle:(NSString *)title {
    defaultDesc.fontSize = [title floatValue];
    [ZHNJSEditorThemeDesc reloadDefaultDesc:defaultDesc];
}

@end
