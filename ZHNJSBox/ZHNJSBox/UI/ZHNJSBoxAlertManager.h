//
//  ZHNJSBoxAlertManager.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/28.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@interface ZHNJSBoxAlertManager : NSObject
+ (void)alertWithJSData:(JSValue *)jsData;
@end
