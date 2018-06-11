//
//  UIImageView+ZHNJSBoxUIImageView.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIImageView+ZHNJSBoxUIImageView.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

@implementation UIImageView (ZHNJSBoxUIImageView)
- (void)setSrc:(NSString *)src {
    [self sd_setImageWithURL:[NSURL URLWithString:src]];
    objc_setAssociatedObject(self, @selector(src), src, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)src {
    return objc_getAssociatedObject(self, _cmd);
}

@end
