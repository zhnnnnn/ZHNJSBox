//
//  UILabel+ZHNJSBoxUILabel.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UILabel+ZHNJSBoxUILabel.h"

@implementation UILabel (ZHNJSBoxUILabel)
- (NSInteger)align {
    return self.textAlignment;
}
- (void)setAlign:(NSInteger)align {
    self.textAlignment = align;
}

- (NSInteger)lines {
    return self.numberOfLines;
}

- (void)setLines:(NSInteger)lines {
    self.numberOfLines = lines;
}

- (BOOL)autoFontSize {
    return self.adjustsFontSizeToFitWidth;
}

- (void)setAutoFontSize:(BOOL)autoFontSize {
    self.adjustsFontSizeToFitWidth = autoFontSize;
}
@end
