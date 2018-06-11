//
//  ZHNJSBoxEngine.m
//  ZHNJSBox
//
//  Created by zhn on 2018/4/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxEngine.h"
#import "ZHNJSBoxHttpManager.h"
#import "ZHNJSBoxLayoutManager.h"
#import "ZHNJSBoxUIParseManager.h"
#import "Masonry.h"
#import "ZHNJSBoxDataBox.h"
#import "ZHNJSBoxRenderManager.h"
#import "ZHNJSBoxColor.h"
#import "UIView+ZHNJSBoxUIView.h"
#import "ZHNJSBoxFont.h"
#import "NSIndexPath+ZHNJSBoxIndexPath.h"
#import "JSValue+judgeNil.h"
#import "UIView+mapViewId.h"
#import "ZHNJSBoxCache.h"
#import "ZHNJSBoxJSContextManager.h"
#import "ZHNJSBoxUIManager.h"

#define ZHNWeakSelf __weak __typeof(self)weakSelf = self;
#define ZHNStrongSelf __strong __typeof(weakSelf)self = weakSelf;

static NSString *const KSwitchIDMapContextNotify = @"KSwitchIDMapContextNotify";
static NSString *const KDefaultIDMapContextNotify = @"KDefaultIDMapContextNotify";
@interface ZHNJSBoxEngine()
@property (nonatomic,strong) JSContext *context;
@property (nonatomic,strong) ZHNJSBoxHttpManager *httpManager;
@property (nonatomic,strong) UIView *idMapDictHostView;
@end

@implementation ZHNJSBoxEngine
- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchIDmapContext:) name:KSwitchIDMapContextNotify object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultIDMapContext:) name:KDefaultIDMapContextNotify object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:KSwitchIDMapContextNotify];
    [[NSNotificationCenter defaultCenter] removeObserver:KDefaultIDMapContextNotify];
    [JSContextManager clearEnvironment];
}

- (void)startEngine {
    if (self.context) {
        return;
    }
    ZHNWeakSelf
    JSContext *context = [[JSContext alloc]init];
    self.context = context;
    [JSContextManager initializeEnvironmentWithContext:context];
    
    context[@"oc_test"] = ^(JSValue *data) {
        NSLog(@"a");
    };
    
    // 打印
    context[@"oc_log"] = ^(JSValue *data) {
        id dataObj = [data toObject];
        if ([dataObj isKindOfClass:[NSNumber class]]) {
            NSLog(@"oc_log === %f",[dataObj floatValue]);
        }else {
           NSLog(@"oc_log === %@",dataObj);
        }
    };
    // 数据类型
    context[@"oc_data_box"] = ^id(JSValue *args,NSString *dataType) {
        return [ZHNJSBoxDataBox dataWithDataArgs:[args toArray] dataType:dataType];
    };
    // 请求
    context[@"oc_request"] = ^(JSValue *request) {
        ZHNStrongSelf
        [self.httpManager callRequestWithEngine:request];
    };
    // 根据id取view
    context[@"oc_id_map_view"] = ^id(JSValue *identity) {
        ZHNStrongSelf
        if (!identity.isNil) {
            return self.idMapDictHostView.mapViewDict[[identity toString]];
        }
        return nil;
    };
    // 显示
    context[@"oc_ui"] = ^(NSString *eventName, JSValue *data) {
        ZHNStrongSelf
        [ZHNJSBoxUIManager handleWithEventName:eventName jsValue:data engine:self];
    };
    // 属性，上下左右 ...
    context[@"oc_LayoutProperty"] = ^id(JSValue *maker ,JSValue *property) {
        return [ZHNJSBoxLayoutManager OCLayoutPropertyDealWithLayoutMaker:maker porperty:property];
    };
    // 关系，equalto ...
    context[@"oc_LayoutRelation"] = ^id(JSValue *maker,JSValue *relationFunc,JSValue *arg) {
        return [ZHNJSBoxLayoutManager OCLayoutRelationDealWithLayoutMaker:maker relationFunc:relationFunc arg:arg];
    };
    // 颜色
    context[@"oc_color"] = ^id(JSValue *colorStr) {
        return [ZHNJSBoxColor colorWithColorString:[colorStr toString]];
    };
    context[@"oc_color_rgba"] = ^id(JSValue *r,JSValue *g,JSValue *b,JSValue *a) {
        return [UIColor colorWithDisplayP3Red:[[r toNumber] floatValue] / 255.0 green:[[g toNumber] floatValue] / 255.0 blue:[[b toNumber] floatValue] / 255.0 alpha:[[a toNumber] floatValue] / 255.0];
    };
    // 字体
    context[@"oc_font"] = ^id(JSValue *v1,JSValue *v2) {
        return [ZHNJSBoxFont fontWithValue1:v1 value2:v2];
    };
    // indexPath
    context[@"oc_indexpath"] = ^id(JSValue *section ,JSValue *row) {
        if (!section.isNil && !row.isNil) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[row toNumber] integerValue] inSection:[[section toNumber] integerValue]];
            return indexPath;
        }
        return nil;
    };
    // 缓存
    context[@"oc_cache"] = ^id(NSString *funcName,JSValue *arg){
        return [ZHNJSBoxCache responseWithFuncName:funcName arg:arg];
    };
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZHNJSBox" ofType:@"js"];
    [self evaluateScriptWithPath:path];
}

- (JSValue *)evaluateScript:(NSString *)script {
    [self startEngine];
    NSString *regexedScript = [self _regexScript:script];
    return [_context evaluateScript:regexedScript];
}

- (JSValue *)evaluateScriptWithPath:(NSString *)path {
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return [self evaluateScript:script];
}

+ (BOOL)isScriptHaveRender:(NSString *)script {
    return [script containsString:@"$ui.render"];
}

+ (void)engineSwitchIDMapViewContext:(UIView *)context {
    [[NSNotificationCenter defaultCenter] postNotificationName:KSwitchIDMapContextNotify object:context];
}

+ (void)engineDefaultIDMapViewContext {
    [[NSNotificationCenter defaultCenter] postNotificationName:KDefaultIDMapContextNotify object:nil];
}

#pragma mark - target action
- (void)switchIDmapContext:(NSNotification *)notify {
    self.idMapDictHostView = notify.object;
}

- (void)defaultIDMapContext:(NSNotification *)notify {
    self.idMapDictHostView = self.containerView;
}

#pragma mark - pravite methods
- (NSString *)_regexScript:(NSString *)script {
    NSString *muScript = [script mutableCopy];
    NSRegularExpression *layoutRegex = [NSRegularExpression regularExpressionWithPattern:@"layout.*?\\}" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSArray *results = [layoutRegex matchesInString:script options:0 range:NSMakeRange(0, script.length)];
    for (NSTextCheckingResult *result in results) {
        if (result.range.location != NSNotFound) {
            // 容错处理
            NSString *layoutStr = [script substringWithRange:result.range];
            if ([layoutStr containsString:@"$layout"]) {
                continue;
            }
            // layout 关系 equalto...
            NSRegularExpression *methodRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\.\\s*(\\w+)\\s*\\(" options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            NSString *lrFormatterStr = [methodRegex stringByReplacingMatchesInString:layoutStr options:0 range:NSMakeRange(0, layoutStr.length) withTemplate:@".__lr(\"$1\")("];
            // layout 属性 left...
            NSRegularExpression *proRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<!\\\\)\\.\\s*(\\w+)\\s*\\." options:NSRegularExpressionDotMatchesLineSeparators error:nil];
            // 这里有待优化，没有找到特别合适的正则方式index最大不超过4是因为 make.left.right.top.bottom 类似这样的关系一条语句当中最多不会超过4。
            NSString *lpFormatterStr;
            for (int index = 0; index < 4; index++) {
                NSString *matchString = index == 0 ? lrFormatterStr : lpFormatterStr;
                lpFormatterStr = [proRegex stringByReplacingMatchesInString:matchString options:0 range:NSMakeRange(0, matchString.length) withTemplate:@".__lp(\"$1\")."];
            }
            // 替换
            muScript = [muScript stringByReplacingOccurrencesOfString:layoutStr withString:lpFormatterStr];
        }
    }
    return muScript;
}

#pragma mark - setters
- (void)setContainerView:(UIView *)containerView {
    _containerView = containerView;
    self.idMapDictHostView = containerView;
}

#pragma mark - getters
- (ZHNJSBoxHttpManager *)httpManager {
    if (_httpManager == nil) {
        _httpManager = [[ZHNJSBoxHttpManager alloc]init];
    }
    return _httpManager;
}

@end
