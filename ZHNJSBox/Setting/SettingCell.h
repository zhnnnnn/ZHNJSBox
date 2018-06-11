//
//  settingCell.h
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (nonatomic, copy) NSString *title;
+ (SettingCell *)createCellWithTableView:(UITableView *)tableView;
@end
