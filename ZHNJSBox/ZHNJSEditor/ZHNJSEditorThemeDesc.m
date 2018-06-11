//
//  ZHNJSEditorThemeDesc.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/1.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorThemeDesc.h"

@implementation ZHNJSEditorThemeDesc
+ (instancetype)descWithFontSize:(CGFloat)fontSize fontName:(NSString *)fontName themeName:(NSString *)themeName showNumberOfLines:(BOOL)showNumberOfLines{
    ZHNJSEditorThemeDesc *desc = [[self alloc] init];
    desc.fontSize = fontSize;
    desc.fontName = fontName;
    desc.themeName = themeName;
    desc.showNumberOfLines = showNumberOfLines;
    return desc;
}

+ (NSArray<NSString *> *)availableFontNames {
    static dispatch_once_t onceToken;
    static NSArray *fontNames = nil;
    dispatch_once(&onceToken, ^{
        fontNames = @[@"Menlo",@"Courier",@"Source Code Pro",@"Monaco",@"Iosevka"];
    });
    return fontNames;
}

+ (NSArray<NSString *> *)availableThemeNames {
    static dispatch_once_t onceToken;
    static NSMutableArray *themeNames = nil;
    dispatch_once(&onceToken, ^{
        NSArray *themes = [[NSBundle mainBundle] pathsForResourcesOfType:@"css" inDirectory:nil];
        themeNames = [NSMutableArray array];
        for (NSString *themePath in themes) {
            NSString *themeName = [themePath.lastPathComponent stringByReplacingOccurrencesOfString:@".css" withString:@""];
            [themeNames addObject:themeName];
        }
    });
    return themeNames;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.fontName = [aDecoder decodeObjectForKey:@"fontName"];
        self.fontSize = [[aDecoder decodeObjectForKey:@"fontSize"] floatValue];
        self.themeName = [aDecoder decodeObjectForKey:@"themeName"];
        self.showNumberOfLines = [[aDecoder decodeObjectForKey:@"showNumberOfLines"] boolValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.fontSize) forKey:@"fontSize"];
    [aCoder encodeObject:self.fontName forKey:@"fontName"];
    [aCoder encodeObject:self.themeName forKey:@"themeName"];
    [aCoder encodeObject:@(self.showNumberOfLines) forKey:@"showNumberOfLines"];
}

+ (ZHNJSEditorThemeDesc *)defaultDesc {
    ZHNJSEditorThemeDesc *desc = [NSKeyedUnarchiver unarchiveObjectWithFile:[self _cachePath]];
    if (!desc) {
        desc = [[ZHNJSEditorThemeDesc alloc] init];
        desc.fontSize = 12;
        desc.fontName = @"Menlo";
        desc.themeName = @"atom-one-dark";
        desc.showNumberOfLines = YES;
        [self reloadDefaultDesc:desc];
    }
    return desc;
}

+  (void)reloadDefaultDesc:(ZHNJSEditorThemeDesc *)desc {
    [NSKeyedArchiver archiveRootObject:desc toFile:[self _cachePath]];
}

+ (NSString *)_cachePath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingPathComponent:@"ZHNJSEditorThemeDesc"];
}
@end
