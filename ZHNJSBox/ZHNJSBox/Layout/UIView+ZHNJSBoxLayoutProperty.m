//
//  UIView+ZHNJSBoxLayoutProperty.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/18.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIView+ZHNJSBoxLayoutProperty.h"

@implementation UIView (ZHNJSBoxLayoutProperty)
- (MASViewAttribute *)left {
    return self.mas_left;
}

- (MASViewAttribute *)top {
    return self.mas_top;
}

- (MASViewAttribute *)right {
    return self.mas_right;
}

- (MASViewAttribute *)bottom {
    return self.mas_bottom;
}

- (MASViewAttribute *)leading {
    return self.mas_leading;
}

- (MASViewAttribute *)trailing {
    return self.mas_trailing;
}

- (MASViewAttribute *)width {
    return self.mas_width;
}

- (MASViewAttribute *)height {
    return self.mas_height;
}

- (MASViewAttribute *)centerX {
    return self.mas_centerX;
}

- (MASViewAttribute *)centerY {
    return self.mas_centerY;
}

- (MASViewAttribute *)baseline {
    return self.mas_baseline;
}
@end
