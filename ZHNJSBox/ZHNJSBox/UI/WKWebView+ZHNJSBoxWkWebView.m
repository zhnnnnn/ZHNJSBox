//
//  WKWebView+ZHNJSBoxWkWebView.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "WKWebView+ZHNJSBoxWkWebView.h"
#import <objc/runtime.h>

@interface WKWebView ()
@property (nonatomic, strong) UIProgressView *progress;
@end

@implementation WKWebView (ZHNJSBoxWkWebView)
- (instancetype)init {
    if (self = [super init]) {
        self.progress = [[UIProgressView alloc]init];
        self.progress.progressTintColor = [UIColor redColor];
        [self addSubview:self.progress];
        [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.progress.frame = CGRectMake(0, 0, self.frame.size.width, 2);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progress.progress = self.estimatedProgress;
        self.progress.hidden = self.estimatedProgress > 0.7 ? YES : NO;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setUrl:(NSString *)url {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)setProgress:(UIProgressView *)progress {
    objc_setAssociatedObject(self, @selector(progress), progress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIProgressView *)progress {
    return objc_getAssociatedObject(self, _cmd);
}
@end
