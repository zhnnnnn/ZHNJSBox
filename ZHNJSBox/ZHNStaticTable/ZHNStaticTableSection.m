//
//  ZHNStaticTableSection.m
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNStaticTableSection.h"
#import <objc/runtime.h>

@implementation ZHNStaticTableSection
- (void)zhn_addRow:(void (^)(ZHNStaticTableRow *))rowHandle {
    ZHNStaticTableRow *row = [[ZHNStaticTableRow alloc]init];
    rowHandle(row);
    [self.rows addObject:row];
}

- (NSMutableArray<ZHNStaticTableRow *> *)rows {
    NSMutableArray *array = objc_getAssociatedObject(self, _cmd);
    if (!array) {
        array = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return array;
}
@end
