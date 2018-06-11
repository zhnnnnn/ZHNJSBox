//
//  ZHNDelegateContainer.m
//  ZHNStaticTable
//
//  Created by zhn on 2018/3/21.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNDelegateContainer.h"

@interface ZHNDelegateContainer()
@property (nonatomic,strong) NSMutableArray *delegates;
@end

@implementation ZHNDelegateContainer
+ (instancetype)zhn_containerWithDelegates:(NSArray<id> *)delegates {
    ZHNDelegateContainer *container = [[ZHNDelegateContainer alloc]init];
    for (id delegate in delegates) {
        [container.delegates addObject:[NSValue valueWithNonretainedObject:delegate]];
    }
    return container;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    for (NSValue *value in self.delegates) {
        id delegate = [value nonretainedObjectValue];
        if ([delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    for (NSValue *value in self.delegates) {
        id delegate = [value nonretainedObjectValue];
        NSMethodSignature *sig = [delegate methodSignatureForSelector:aSelector];
        if (sig) {
            return sig;
        }
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    for (NSValue *value in self.delegates) {
        id delegate = [value nonretainedObjectValue];
        if ([delegate respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegate];
        }
    }
}

#pragma mark - getters
- (NSMutableArray *)delegates {
    if (_delegates == nil) {
        _delegates = [NSMutableArray array];
    }
    return _delegates;
}
@end
