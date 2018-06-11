//
//  FontNameSettingVC.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "FontNameSettingVC.h"

@interface FontNameSettingVC ()

@end

@implementation FontNameSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = [ZHNJSEditorThemeDesc availableFontNames];
    [self.tableView reloadData];
}

- (NSString *)judgeProperty {
    return self.defaultDesc.fontName;
}

- (void)reloadTheme:(ZHNJSEditorThemeDesc *)defaultDesc selectTitle:(NSString *)title {
    defaultDesc.fontName = title;
    [ZHNJSEditorThemeDesc reloadDefaultDesc:defaultDesc];
}


@end
