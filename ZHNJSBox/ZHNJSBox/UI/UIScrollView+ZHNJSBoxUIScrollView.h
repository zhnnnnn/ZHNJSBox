//
//  UIScrollView+ZHNJSBoxUIScrollView.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxUIScrollViewExport <JSExport>
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) BOOL pagingEnabled;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL alwaysBounceVertical;
@property (nonatomic, assign) BOOL alwaysBounceHorizontal;
@property (nonatomic, assign) BOOL showsHorizontalIndicator;
@property (nonatomic, assign) BOOL showsVerticalIndicator;
@property (nonatomic, assign) BOOL tracking;
@property (nonatomic, assign) BOOL dragging;
@property (nonatomic, assign) BOOL decelerating;
@property (nonatomic, assign) NSInteger keyboardDismissMode;
- (void)beginRefreshing;
- (void)endRefreshing;
@end

@interface UIScrollView (ZHNJSBoxUIScrollView) <ZHNJSBoxUIScrollViewExport>
- (void)beginRefreshing;
- (void)endRefreshing;
@end
