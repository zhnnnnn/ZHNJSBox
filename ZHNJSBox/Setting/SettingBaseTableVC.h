//
//  ThemeSettingTableVC.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHNJSEditorThemeDesc.h"

@interface SettingBaseTableVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) ZHNJSEditorThemeDesc *defaultDesc;
- (void)reloadTheme:(ZHNJSEditorThemeDesc *)defaultDesc selectTitle:(NSString *)title;
- (NSString *)judgeProperty;
@end
