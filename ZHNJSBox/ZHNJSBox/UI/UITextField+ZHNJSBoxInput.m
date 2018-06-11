//
//  UITextField+ZHNJSBoxInput.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UITextField+ZHNJSBoxInput.h"
#import <objc/runtime.h>
#import "UIView+ZHNJSBoxUIView.h"
#import "ZHNJSBoxJSContextManager.h"

static NSString *const EventReturned = @"returned";
static NSString *const EventDidBeginEditing = @"didBeginEditing";
static NSString *const EventDidEndEditing = @"didEndEditing";
static NSString *const EventChanged = @"changed";

@interface UITextField()<UITextFieldDelegate>

@end

@implementation UITextField (ZHNJSBoxInput)
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        self.layer.cornerRadius = 5;
        self.delegate = self;
        [self addTarget:self action:@selector(textChanging:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

#pragma mark - delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [JSContextManager callJsFuncWithObj:self eventName:EventDidBeginEditing args:@[textField]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [JSContextManager callJsFuncWithObj:self eventName:EventDidEndEditing args:@[textField]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [JSContextManager callJsFuncWithObj:self eventName:EventReturned args:@[textField]];
    return YES;
}

- (void)textChanging:(UITextField *)textField {
    [JSContextManager callJsFuncWithObj:self eventName:EventChanged args:@[textField]];
}

#pragma mark - property
- (void)setType:(NSInteger)type {
    self.keyboardType = type;
}

- (NSInteger)type {
    return self.keyboardType;
}

- (void)setDarkKeyboard:(BOOL)darkKeyboard {
    self.keyboardAppearance = darkKeyboard ? UIKeyboardAppearanceDark : UIKeyboardAppearanceDefault;
}

- (void)setAlign:(NSInteger)align {
    self.textAlignment = align;
}

- (void)setSecure:(BOOL)secure {
    self.secureTextEntry = secure;
}

- (BOOL)secure {
    return self.secureTextEntry;
}

- (void)focus {
    [self becomeFirstResponder];
}

- (void)blur {
    [self resignFirstResponder];
}

@end
