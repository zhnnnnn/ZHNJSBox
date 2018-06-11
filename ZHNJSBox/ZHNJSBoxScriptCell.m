//
//  ZHNJSBoxScriptCell.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxScriptCell.h"
#import "Masonry.h"

@interface ZHNJSBoxScriptCell ()
@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *runBtn;
@end

@implementation ZHNJSBoxScriptCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.cardView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.runBtn];
        [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.runBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.cardView.mas_right).offset(-30);
        }];
    }
    return self;
}

+ (ZHNJSBoxScriptCell *)createCellWithTableView:(UITableView *)tableView {
    ZHNJSBoxScriptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ZHNJSBoxScriptCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}

- (void)runScriptAction {
    [self.delegate ZHNJSBoxScriptCellSelectToRun:self.scriptName];
}

- (void)setScriptName:(NSString *)scriptName {
    _scriptName = scriptName;
    self.nameLabel.text = scriptName;
}
#pragma mark - getters
- (UIView *)cardView {
    if (_cardView == nil) {
        _cardView = [[UIView alloc] init];
        _cardView.layer.cornerRadius = 10;
        _cardView.backgroundColor = [UIColor whiteColor];
    }
    return _cardView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"Monaco" size:20];
    }
    return _nameLabel;
}

- (UIButton *)runBtn {
    if (_runBtn == nil) {
        _runBtn = [[UIButton alloc] init];
        _runBtn.titleLabel.font = [UIFont fontWithName:@"Monaco" size:16];
        [_runBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_runBtn setTitle:@"运行" forState:UIControlStateNormal];
        [_runBtn addTarget:self action:@selector(runScriptAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _runBtn;
}

@end
