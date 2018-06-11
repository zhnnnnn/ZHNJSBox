//
//  WKWebView+ZHNJSBoxWkWebView.h
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZHNJSBoxWkWebViewExport <JSExport>
@property (nonatomic, copy) NSString *url;
@end

@interface WKWebView (ZHNJSBoxWkWebView)<ZHNJSBoxWkWebViewExport>
@property (nonatomic, copy) NSString *url;
@end
