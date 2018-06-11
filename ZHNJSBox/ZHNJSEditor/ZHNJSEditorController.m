//
//  ZHNJSEditorController.m
//  ZHNJSBox
//
//  Created by zhn on 2018/6/4.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSEditorController.h"
#import "ZHNJSEditorHighlighter.h"
#import "ZHNJSEditorTextStorage.h"
#import "ZHNJSEditorTextView.h"
#import "ZHNJSEditorLayoutManager.h"

@interface ZHNJSEditorController ()
@property (nonatomic, strong) ZHNJSEditorTextView *textView;
@property (nonatomic, strong) ZHNJSEditorTextStorage *textStorage;
@end

@implementation ZHNJSEditorController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    
    self.textView.text = self.script;
    //    NSPredicate todo 本地搜索 https://www.jianshu.com/p/2c98d9f7eaaf
}

- (void)setScript:(NSString *)script {
    _script = script;
    self.textView.text = script;
}

#pragma mark - pravite methods
- (void)_setupUI {
    ZHNJSEditorTextStorage *storage = [[ZHNJSEditorTextStorage alloc] init];
    self.textStorage = storage;
    ZHNJSEditorLayoutManager *layoutManager = [[ZHNJSEditorLayoutManager alloc] init];
    [storage addLayoutManager:layoutManager];
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.view.bounds.size.width, CGFLOAT_MAX)];
    [layoutManager addTextContainer:container];
    self.textView = [[ZHNJSEditorTextView alloc] initWithFrame:self.view.bounds textContainer:container];
    self.textView.backgroundColor = storage.themeBackgroundColor;
    if (self.textStorage.isShowLineNumber) {
        self.textView.textContainerInset = UIEdgeInsetsMake(0, storage.lineNumWidth, 0, 0);
    }
    [self.view addSubview:self.textView];
    self.textView.frame = self.view.bounds;
}
@end
