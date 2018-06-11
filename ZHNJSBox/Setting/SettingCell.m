//
//  settingCell.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "SettingCell.h"
#import "Masonry.h"

@interface SettingCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation SettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont fontWithName:@"Monaco" size:17];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(20);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.nameLabel.text = title;
}

+ (SettingCell *)createCellWithTableView:(UITableView *)tableView {
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

@end
