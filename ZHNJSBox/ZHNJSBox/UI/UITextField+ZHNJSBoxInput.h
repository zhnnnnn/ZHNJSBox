//
//  UITextField+ZHNJSBoxInput.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxInputExport <JSExport>
@property (nonatomic, assign) NSInteger type;// 键盘类型
@property (nonatomic, assign) BOOL darkKeyboard;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSInteger align;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) NSInteger clearButtonMode;
@property (nonatomic, assign) BOOL clearsOnBeginEditing;
@property (nonatomic, assign) BOOL *editing;
@property (nonatomic, assign) BOOL secure;
- (void)focus;
- (void)blur;
@end

@interface UITextField (ZHNJSBoxInput) <ZHNJSBoxInputExport>
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL darkKeyboard;
@property (nonatomic, assign) NSInteger align;
@property (nonatomic, assign) BOOL secure;
- (void)focus;
- (void)blur;
@end
