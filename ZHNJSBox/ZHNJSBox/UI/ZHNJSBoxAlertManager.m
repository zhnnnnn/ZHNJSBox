//
//  ZHNJSBoxAlertManager.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/28.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxAlertManager.h"

@implementation ZHNJSBoxAlertManager
+ (void)alertWithJSData:(JSValue *)jsData {
    UIAlertController *alert = [[UIAlertController alloc]init];

    JSValue *actions = jsData[@"actions"];
    NSArray *ocActions = [actions toArray];
    if (ocActions.count == 0) {
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];
    }else {
        for (int index = 0; index < ocActions.count; index++) {
//            JSValue *
//            UIAlertAction *act = [UIAlertAction actionWithTitle:<#(nullable NSString *)#> style:<#(UIAlertActionStyle)#> handler:<#^(UIAlertAction * _Nonnull action)handler#>]
        }
    }
}
@end
