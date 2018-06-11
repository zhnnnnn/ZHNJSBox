//
//  UISegmentedControl+ZHNJSBoxSegmentControl.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/30.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxSegmentControlExport <JSExport>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSNumber *index;
@end

@interface UISegmentedControl (ZHNJSBoxSegmentControl)<ZHNJSBoxSegmentControlExport>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSNumber *index;
@end
