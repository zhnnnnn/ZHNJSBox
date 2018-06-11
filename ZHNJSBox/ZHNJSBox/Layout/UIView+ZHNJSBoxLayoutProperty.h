//
//  UIView+ZHNJSBoxLayoutProperty.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/18.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Masonry.h"

@protocol ZHNJSBoxLayoutPropertyExport <JSExport>
@property (nonatomic, strong, readonly) MASViewAttribute *left;
@property (nonatomic, strong, readonly) MASViewAttribute *top;
@property (nonatomic, strong, readonly) MASViewAttribute *right;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *leading;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *width;
@property (nonatomic, strong, readonly) MASViewAttribute *height;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY;
@property (nonatomic, strong, readonly) MASViewAttribute *baseline;
@end

@interface UIView (ZHNJSBoxLayoutProperty)<ZHNJSBoxLayoutPropertyExport>
@property (nonatomic, strong, readonly) MASViewAttribute *left;
@property (nonatomic, strong, readonly) MASViewAttribute *top;
@property (nonatomic, strong, readonly) MASViewAttribute *right;
@property (nonatomic, strong, readonly) MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) MASViewAttribute *leading;
@property (nonatomic, strong, readonly) MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) MASViewAttribute *width;
@property (nonatomic, strong, readonly) MASViewAttribute *height;
@property (nonatomic, strong, readonly) MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) MASViewAttribute *centerY;
@property (nonatomic, strong, readonly) MASViewAttribute *baseline;
@end
