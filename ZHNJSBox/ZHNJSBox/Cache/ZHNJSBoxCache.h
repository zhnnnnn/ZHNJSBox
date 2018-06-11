//
//  ZHNJSBoxCache.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/23.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHNJSBoxCache : NSObject
+ (id)responseWithFuncName:(NSString *)funcName arg:(JSValue *)arg;

+ (void)set:(id)obj  inScript:(NSString *)scriptName forKey:(NSString *)key;
+ (id)objForKey:(NSString *)key inScript:(NSString *)script;
@end
