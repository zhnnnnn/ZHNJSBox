//
//  JSValue+judgeNil.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/17.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "JSValue+judgeNil.h"

@implementation JSValue (judgeNil)
- (BOOL)isNil {
    return self.isNull || self.isUndefined;
}
@end
