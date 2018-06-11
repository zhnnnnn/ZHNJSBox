//
//  ThemeSettingTableVC.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ThemeSettingTableVC.h"
#import "ThemePreview.h"

@interface ThemeSettingTableVC ()
@property (nonatomic,strong) ThemePreview *preview;
@end

@implementation ThemeSettingTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preview = [[ThemePreview alloc] init];
    [self.view addSubview:self.preview];
    self.preview.frame = self.view.bounds;
    self.titles = [ZHNJSEditorThemeDesc availableThemeNames];
    [self.tableView reloadData];
}

- (NSString *)judgeProperty {
    return self.defaultDesc.themeName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [self.preview showAnimateWithThmeName:self.titles[indexPath.row] Complete:nil];
}

- (void)reloadTheme:(ZHNJSEditorThemeDesc *)defaultDesc selectTitle:(NSString *)title {
    // nothing
}

@end
