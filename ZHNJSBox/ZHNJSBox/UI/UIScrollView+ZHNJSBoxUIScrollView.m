//
//  UIScrollView+ZHNJSBoxUIScrollView.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIScrollView+ZHNJSBoxUIScrollView.h"
#import "UIView+ZHNJSBoxUIView.h"
#import <objc/runtime.h>
#import "JSValue+judgeNil.h"
#import "ZHNJSBoxJSContextManager.h"

static NSString *const EventPull = @"pulled";

@interface UIScrollView()<UIScrollViewDelegate>
@end

@implementation UIScrollView (ZHNJSBoxUIScrollView)
- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
//        UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
//        [refreshControl addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
//        self.refreshControl = refreshControl;
    }
    return self;
}

- (void)refreshAction:(UIRefreshControl *)control {
    [JSContextManager callJsFuncWithObj:self eventName:EventPull args:@[control]];
}

- (void)beginRefreshing {
    [self.refreshControl beginRefreshing];
}

- (void)endRefreshing {
    [self.refreshControl endRefreshing];
}
@end
