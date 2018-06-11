//
//  ZHNJSBoxFont.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHNJSBoxFont : NSObject
+ (UIFont *)fontWithValue1:(JSValue *)value1 value2:(JSValue *)value2;
@end
