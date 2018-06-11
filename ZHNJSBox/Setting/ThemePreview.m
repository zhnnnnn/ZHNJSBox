//
//  ThemePreview.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ThemePreview.h"
#import "ZHNJSEditorHighlighter.h"
#import "Masonry.h"

static CGFloat KDuration = 0.4;
@interface ThemePreview ()
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *preview;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) ZHNJSEditorThemeDesc *defaultDesc;
@property (nonatomic,strong) ZHNJSEditorHighlighter *highlighter;
@property (nonatomic,copy) NSString *themeName;
@end

@implementation ThemePreview
- (instancetype)init {
    if (self = [super init]) {
        self.hidden = YES;
        self.defaultDesc = [ZHNJSEditorThemeDesc defaultDesc];
        [self addSubview:self.maskView];
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self addSubview:self.preview];
        [self.preview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self.mas_bottom).offset(20);
            make.height.mas_equalTo(200);
        }];
        [self.preview addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.preview addSubview:self.confirmBtn];
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.inset(15);
            make.height.mas_equalTo(40);
        }];
        
        UITapGestureRecognizer *disMissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissAction)];
        [self addGestureRecognizer:disMissTap];
    }
    return self;
}

- (void)disMissAction {
    [self hideAnimateComplete:nil];
}

- (void)confirmChangeThemeAction {
    self.defaultDesc.themeName = self.themeName;
    [ZHNJSEditorThemeDesc reloadDefaultDesc:self.defaultDesc];
    [self hideAnimateComplete:nil];
}

- (void)showAnimateWithThmeName:(NSString *)themeName Complete:(void (^)())complete {
    // 显示
    self.highlighter = [ZHNJSEditorHighlighter highlighterWithCustomThemeDesc:^ZHNJSEditorThemeDesc *{
        return [ZHNJSEditorThemeDesc descWithFontSize:self.defaultDesc.fontSize fontName:self.defaultDesc.fontName themeName:themeName showNumberOfLines:YES];
    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"themeShow" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    id text = [self.highlighter highlightJSCode:script];
    self.textView.attributedText = [self.highlighter highlightJSCode:script];
    self.textView.backgroundColor = self.highlighter.theme.currentThemeBackgroundColor;
    self.themeName = themeName;
    
    // 动画
    self.hidden = NO;
    [self.preview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.bottom.equalTo(self).offset(-20);
        make.height.mas_equalTo(200);
    }];
    [UIView animateWithDuration:KDuration animations:^{
        [self layoutIfNeeded];
        self.maskView.alpha = 1;
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
    }];
}

- (void)hideAnimateComplete:(void (^)())complete {
    [self.preview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self.mas_bottom).offset(20);
        make.height.mas_equalTo(200);
    }];
    [UIView animateWithDuration:KDuration animations:^{
        [self layoutIfNeeded];
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (complete) {
            complete();
        }
    }];
}

#pragma mark - getters
- (UIView *)preview {
    if (_preview == nil) {
        _preview = [[UIView alloc] init];
        _preview.layer.cornerRadius = 25;
    }
    return _preview;
}

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 25;
    }
    return _textView;
}

- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _maskView.alpha = 0;
    }
    return _maskView;
}

- (UIButton *)confirmBtn {
    if (_confirmBtn == nil) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmChangeThemeAction) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitle:@"好的" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = [UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1.0];
        _confirmBtn.layer.cornerRadius = 10;
    }
    return _confirmBtn;
}
@end

