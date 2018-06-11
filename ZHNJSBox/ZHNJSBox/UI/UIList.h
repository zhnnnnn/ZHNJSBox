//
//  UIList.h
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ZHNJSBoxDataBox.h"

@protocol ZHNJSBoxUIListExport <JSExport>
@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,strong) JSValue *data;
@property (nonatomic,strong) JSValue *template;
@property (nonatomic,strong) JSValue *header;
@property (nonatomic,strong) JSValue *footer;
@property (nonatomic,strong) UIColor *separatorColor;
- (id)object:(NSIndexPath *)indexPath;
- (id)cell:(NSIndexPath *)indexPath;
- (void)delete:(id)idx;
- (void)insert:(JSValue *)value;
@end

@interface UIList : UITableView <ZHNJSBoxUIListExport>
@property (nonatomic,strong) JSValue *data;
@property (nonatomic,strong) JSValue *template;
@property (nonatomic,strong) JSValue *header;
@property (nonatomic,strong) JSValue *footer;
@property (nonatomic,strong) JSValue *actions;
- (id)object:(NSIndexPath *)indexPath;
- (id)cell:(NSIndexPath *)indexPath;
- (void)delete:(id)idx;
- (void)insert:(JSValue *)value;
@end
