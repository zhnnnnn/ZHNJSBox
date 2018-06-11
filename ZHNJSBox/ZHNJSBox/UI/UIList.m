//
//  UIList.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/5/10.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "UIList.h"
#import "Masonry.h"
#import "ZHNJSBoxRenderManager.h"
#import "UIView+ZHNJSBoxUIView.h"
#import "UIView+mapViewId.h"
#import "ZHNJSBoxUIParseManager.h"
#import "JSValue+judgeNil.h"
#import "ZHNJSBoxEngine.h"
#import "UIView+mapViewId.h"
#import "ZHNJSBoxJSContextManager.h"

typedef NS_ENUM(NSInteger,ZHNListType) {
    ZHNListTypeSingleSection,
    ZHNListTypeMultiSection,
    ZHNListTypeStaticCell
};

static NSString *const EventDidSelect = @"didSelect";
static NSString *const EventRowHeight = @"rowHeight";

@interface UIList ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) ZHNListType listType;
@property (nonatomic, assign) BOOL dynamicHeight;
@end

@implementation UIList
- (instancetype)init {
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.listType == ZHNListTypeSingleSection) {
        return 1;
    }else {
        return [[self.data toArray] count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listType == ZHNListTypeSingleSection) {
        return [[self.data toArray] count];;
    }else {
        return [[self.data[section][@"rows"] toArray] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (self.listType) {
        case ZHNListTypeSingleSection:
        case ZHNListTypeMultiSection:
            cell = [self _normalCellWithTable:tableView indexPath:indexPath];
            break;
        case ZHNListTypeStaticCell:
            cell = [self _staticCellWithTableView:tableView indexPath:indexPath];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dynamicHeight) {
        return [[[JSContextManager callJsFuncWithObj:self eventName:EventRowHeight args:@[self,indexPath]] toNumber] floatValue];
    }
    return self.rowHeight;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id data = [self _dataForIndexPath:indexPath];
    NSMutableArray *args = [NSMutableArray arrayWithArray:@[self,indexPath]];
    if (data) {
        [args addObject:data];
    }
    [JSContextManager callJsFuncWithObj:self eventName:EventDidSelect args:args];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger actionCount = [self.actions toDictionary].allKeys.count;
    NSMutableArray *actions = [NSMutableArray array];
    for (int index = 0; index < actionCount; index++) {
        JSValue *value = self.actions[index];
        JSValue *func = value[@"handler"];
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            [func callWithArguments:@[action,indexPath]];
        }];
        action.title = [value[@"title"] toString];
        action.backgroundColor = [UIColor lightGrayColor];
        [actions addObject:action];
    }
    return actions;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.actions ? YES : NO;
}

#pragma mark - 父类
- (void)eventsDealingWithEventName:(NSString *)eventsName jsfunc:(JSValue *)jsfunc {
    [super eventsDealingWithEventName:eventsName jsfunc:jsfunc];
    if ([eventsName isEqualToString:EventRowHeight]) {
        self.dynamicHeight = YES;
    }
}

#pragma mark - pravite methods
- (UITableViewCell *)_normalCellWithTable:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        if (self.template) {
            [ZHNJSBoxRenderManager renderUIWithJSViews:self.template superView:cell.contentView];
        }
    }
    // 数据赋值
    JSValue *jsData = [self _dataForIndexPath:indexPath];
    id ocData = [jsData toObject];
    if ([ocData isKindOfClass:[NSString class]]) {
        cell.textLabel.text = ocData ;
    }else {
        NSDictionary *objDict = [jsData toDictionary];
        for (NSString *idKey in [objDict allKeys]) {
            UIView *fitView = cell.contentView.mapViewDict[idKey];
            NSDictionary *props = objDict[idKey];
            if (![props isKindOfClass:[NSDictionary class]]) {continue;}
            for (NSString *key in props.allKeys) {
                [fitView setValue:props[key] forKey:key];
            }
        }
    }
    return cell;
}

- (UITableViewCell *)_staticCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    JSValue *jsViews = [self _dataForIndexPath:indexPath];
    if (jsViews) {
       [ZHNJSBoxRenderManager renderUIWithJSViews:@[jsViews] superView:cell.contentView];
    }
    return cell;
}

- (id)_dataForIndexPath:(NSIndexPath *)indexPath {
    if (self.listType == ZHNListTypeSingleSection) {
        return self.data[indexPath.row];
    }else {
        JSValue *jsSection = self.data[indexPath.section];
        return jsSection[@"rows"][indexPath.row];
    }
}

- (UIView *)_headerFooterView:(JSValue *)jsValue {
    UIView *view = [[UIView alloc]init];
    UIView *subView = [ZHNJSBoxUIParseManager parsingViewForJSValue:jsValue superView:view idMapViewDict:nil];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    NSDictionary *dict = [jsValue toDictionary];
    if (dict) {
        CGFloat height = [dict[@"props"][@"height"] floatValue];
        view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    }
    return view;
}

#pragma mark - public methods
- (id)object:(NSIndexPath *)indexPath {
    return [self _dataForIndexPath:indexPath];
}

- (id)cell:(NSIndexPath *)indexPath {
    return [self cellForRowAtIndexPath:indexPath];
}

- (void)delete:(id)idx {
    JSContext *ctx = [JSContext currentContext];
    JSValue *jsDeleteFunc = ctx[@"_deleteData"];
    BOOL success = [jsDeleteFunc callWithArguments:@[self,idx]];
    if (!success) {return;}
    NSArray *indexPaths;
    if ([idx isKindOfClass:[NSIndexPath class]]) {
        indexPaths = @[idx];
    }else {
        indexPaths = @[[NSIndexPath indexPathForRow:[idx integerValue] inSection:0]];
    }
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insert:(JSValue *)value {
    JSContext *ctx = [JSContext currentContext];
    JSValue *jsInsertFunc = ctx[@"_insertData"];
    BOOL success = [jsInsertFunc callWithArguments:@[self,value]];
    if (!success) {return;}
    NSArray *indexPaths;
    if (value[@"index"]) {
        indexPaths = @[[NSIndexPath indexPathForRow:[[value[@"index"] toObject] integerValue] inSection:0]];
    }else {
        indexPaths = @[value[@"indexPath"]];
    }
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - setters
- (void)setData:(JSValue *)data {
    [JSContextManager addJsValueWithObject:self name:NSStringFromSelector(@selector(data)) jsValue:data];
    self.listType = ZHNListTypeSingleSection;
    JSValue *firstData = data[0];
    if (data) {
        JSValue *rows = firstData[@"rows"];
        if (!rows.isNil) {
            self.listType = ZHNListTypeMultiSection;
            if (firstData[@"layout"]&&firstData[@"type"]) {// jsvalue 里有layout的情况下判断是静态cell，这个判断条件不是特别好。
                self.listType = ZHNListTypeStaticCell;
            }
        }
    }
    [self reloadData];
}

- (JSValue *)data {
    return [JSContextManager getJsValueWithObject:self name:NSStringFromSelector(@selector(data))];
}

// -
- (void)setTemplate:(JSValue *)template {
    [JSContextManager addJsValueWithObject:self name:NSStringFromSelector(@selector(template)) jsValue:template];
}

- (JSValue *)template {
    return [JSContextManager getJsValueWithObject:self name:NSStringFromSelector(@selector(template))];
}

// -
- (void)setHeader:(JSValue *)header {
    self.tableHeaderView = [self _headerFooterView:header];
}

- (void)setFooter:(JSValue *)footer {
    self.tableFooterView = [self _headerFooterView:footer];
}

// -
- (void)setActions:(JSValue *)actions {
    [JSContextManager addJsValueWithObject:self name:NSStringFromSelector(@selector(actions)) jsValue:actions];
}

- (JSValue *)actions {
    return [JSContextManager getJsValueWithObject:self name:NSStringFromSelector(@selector(actions))];
}

@end
