//
//  UILabel+ZHNJSBoxUILabel.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxUILabelExport <JSExport>
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) NSInteger align;
@property (nonatomic, assign) NSInteger lines;
@property (nonatomic, assign) BOOL autoFontSize;
@end

@interface UILabel (ZHNJSBoxUILabel) <ZHNJSBoxUILabelExport>
@property (nonatomic, assign) NSInteger align;
@property (nonatomic, assign) NSInteger lines;
@property (nonatomic, assign) BOOL autoFontSize;
@end
