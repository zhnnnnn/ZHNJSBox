//
//  NSMutableDictionary+ZHNJSBoxSafeSet.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/25.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ZHNJSBoxSafeSet)
- (void)zhn_safeSetObject:(id)object forKey:(NSString *)key;
@end
