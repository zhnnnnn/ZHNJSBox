//
//  ZHNJSBoxHttpManager.m
//  ZHNJSBox
//
//  Created by zhn on 2018/4/24.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxHttpManager.h"
#import "AFNetworking.h"
#import "NSMutableDictionary+ZHNJSBoxSafeSet.h"

@interface ZHNJSBoxHttpManager()
@property (nonatomic,strong) AFURLSessionManager *sessionManager;
@end

@implementation ZHNJSBoxHttpManager
- (void)callRequestWithEngine:(JSValue *)engine {
    // 解析参数
    NSString *method = [engine[@"method"] toString];
    method = method ? method : @"GET";
    NSString *url = [engine[@"url"] toString];
    NSDictionary *form = [engine[@"form"] toDictionary];
    NSDictionary *header = [engine[@"header"] toDictionary];
    NSDictionary *body = [engine[@"body"] toDictionary];
    JSValue *jsFunc = engine[@"handler"];
    
    // 做一层判断
    if (!url) {
        NSLog(@"$http 必须传url");
        return;
    }
    
    // request
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:method URLString:url parameters:form error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置request header
    if (header) {
        for (NSString *key in header.allKeys) {
            [request setValue:header[key] forHTTPHeaderField:key];
        }
    }
    // 设置request body
    if (body) {
        NSData *bodyData = [NSKeyedArchiver archivedDataWithRootObject:header];
        [request setHTTPBody:bodyData];
    }
    NSURLSessionDataTask *task =  [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSString *responseString = [[NSString alloc]initWithData:responseObject     encoding:NSUTF8StringEncoding];
        NSDictionary *jsArgs = [self _getJsArgumentsWithResponse:(NSHTTPURLResponse *)response reponseObjectString:responseString error:error];
        [jsFunc callWithArguments:@[jsArgs]];
    }];
    [task resume];
}


- (NSDictionary *)_getJsArgumentsWithResponse:(NSHTTPURLResponse *)response reponseObjectString:(NSString *)responseString error:(NSError *)error {
    // js dict
    NSMutableDictionary *jsArguments = [NSMutableDictionary dictionary];
    
    // response
    NSMutableDictionary *jsResponseDict = [NSMutableDictionary dictionary];
    [jsResponseDict zhn_safeSetObject:response.URL.absoluteString forKey:@"url"];
    [jsResponseDict zhn_safeSetObject:response.MIMEType forKey:@"MIMEType"];
    [jsResponseDict zhn_safeSetObject:@(response.expectedContentLength) forKey:@"expectedContentLength"];
    [jsResponseDict zhn_safeSetObject:@(response.statusCode) forKey:@"statusCode"];
    [jsResponseDict zhn_safeSetObject:response.allHeaderFields forKey:@"headers"];
    [jsArguments zhn_safeSetObject:jsResponseDict forKey:@"response"];
    
    // response data string
    [jsArguments zhn_safeSetObject:[ZHNJSBoxHttpManager _dictionaryWithJsonString:responseString] forKey:@"data"];
    
    // error
    NSMutableDictionary *jsErrorDict = [NSMutableDictionary dictionary];
    [jsErrorDict zhn_safeSetObject:@(error.code) forKey:@"code"];
    [jsErrorDict zhn_safeSetObject:error.userInfo forKey:@"userInfo"];
    [jsErrorDict zhn_safeSetObject:error.localizedDescription forKey:@"localizedDescription"];
    [jsErrorDict zhn_safeSetObject:error.localizedFailureReason forKey:@"localizedFailureReason"];
    [jsArguments zhn_safeSetObject:jsErrorDict forKey:@"error"];
    
    return [jsArguments copy];
}

+ (NSDictionary *)_dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark - getters
- (AFURLSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        // reponse
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",nil];
        _sessionManager.responseSerializer = responseSerializer;
    }
    return _sessionManager;
}
@end
