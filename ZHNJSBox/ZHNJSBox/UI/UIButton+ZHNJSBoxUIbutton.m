//
//  UIButton+ZHNJSBoxUIbutton.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIButton+ZHNJSBoxUIbutton.h"
#import "UIButton+WebCache.h"

@implementation UIButton (ZHNJSBoxUIbutton)
- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (UIFont *)font {
    return self.titleLabel.font;
}

- (void)setFont:(UIFont *)font {
    self.titleLabel.font = font;
}

- (void)setSrc:(NSString *)src {
    [self sd_setImageWithURL:[NSURL URLWithString:src] forState:UIControlStateNormal];
}

@end
