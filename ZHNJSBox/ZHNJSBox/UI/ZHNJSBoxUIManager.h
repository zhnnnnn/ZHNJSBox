//
//  ZHNJSBoxUIManager.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/28.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZHNJSBoxEngine.h"

@interface ZHNJSBoxUIManager : NSObject
+ (void)handleWithEventName:(NSString *)eventName jsValue:(JSValue *)value engine:(ZHNJSBoxEngine *)engine;
@end
