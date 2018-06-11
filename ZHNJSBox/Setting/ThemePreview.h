//
//  ThemePreview.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/6/6.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemePreview : UIView
- (void)showAnimateWithThmeName:(NSString *)themeName Complete:(void (^)())complete;
- (void)hideAnimateComplete:(void(^)())complete;
@end
