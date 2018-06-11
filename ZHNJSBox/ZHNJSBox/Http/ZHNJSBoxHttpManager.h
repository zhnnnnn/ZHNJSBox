//
//  ZHNJSBoxHttpManager.h
//  ZHNJSBox
//
//  Created by zhn on 2018/4/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZHNJSBoxHttpManager : NSObject
- (void)callRequestWithEngine:(JSValue *)engine;
@end
