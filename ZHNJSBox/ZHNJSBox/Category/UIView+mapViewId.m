//
//  UIView+mapViewId.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/11.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIView+mapViewId.h"
#import <objc/runtime.h>

@implementation UIView (mapViewId)
- (NSMutableDictionary *)mapViewDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}
@end
