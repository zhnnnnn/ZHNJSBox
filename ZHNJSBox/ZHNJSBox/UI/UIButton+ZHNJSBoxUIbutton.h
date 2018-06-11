//
//  UIButton+ZHNJSBoxUIbutton.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxUIbuttonExport <JSExport>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSString *src;
@end

@interface UIButton (ZHNJSBoxUIbutton)<ZHNJSBoxUIbuttonExport>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) NSString *src;
@end
