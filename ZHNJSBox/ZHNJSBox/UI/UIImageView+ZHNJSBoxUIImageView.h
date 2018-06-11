//
//  UIImageView+ZHNJSBoxUIImageView.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxUIImageViewExport <JSExport>
@property (nonatomic, copy) NSString *src;
@end

@interface UIImageView (ZHNJSBoxUIImageView) <ZHNJSBoxUIImageViewExport>
@property (nonatomic, copy) NSString *src;
@end
