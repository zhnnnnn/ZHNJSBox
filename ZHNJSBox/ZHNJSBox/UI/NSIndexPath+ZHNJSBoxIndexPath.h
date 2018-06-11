//
//  NSIndexPath+ZHNJSBoxIndexPath.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/17.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol ZHNJSBoxIndexPathExport <JSExport>
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@end

@interface NSIndexPath (ZHNJSBoxIndexPath) <ZHNJSBoxIndexPathExport>

@end
