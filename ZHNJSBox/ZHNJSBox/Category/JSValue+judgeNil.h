//
//  JSValue+judgeNil.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/17.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSValue (judgeNil)
@property (nonatomic, assign ,readonly) BOOL isNil;
@end
