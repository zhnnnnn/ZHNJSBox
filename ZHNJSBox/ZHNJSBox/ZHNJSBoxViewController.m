//
//  ZHNJSBoxViewController.m
//  ZHNJSBox
//
//  Created by zhn on 2018/5/22.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ZHNJSBoxViewController.h"
#import "ZHNJSBoxEngine.h"
#import "Masonry.h"

@interface ZHNJSBoxViewController ()<UINavigationControllerDelegate,ZHNJSBoxEngineDelegate>
@property (nonatomic, strong) ZHNJSBoxEngine *jsBox;
@end

@implementation ZHNJSBoxViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.navigationBar.barTintColor = [UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1.0];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismissController)];
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (instancetype)controllerWithScript:(NSString *)script {
    UIViewController *rootController = [[UIViewController alloc]init];
    rootController.view.backgroundColor = [UIColor whiteColor];
    ZHNJSBoxViewController *controller = [[ZHNJSBoxViewController alloc]initWithRootViewController:rootController];
    controller.jsBox.containerView = rootController.view;
    [controller.jsBox evaluateScript:script];
    return controller;
}

#pragma mark - delegates
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.jsBox.containerView = viewController.view;
}

- (void)ZHNJSBoxPushAction {
    UIViewController *controller = [[UIViewController alloc]init];
    controller.view.backgroundColor = [UIColor whiteColor];
    self.jsBox.containerView = controller.view;
    [self pushViewController:controller animated:YES];
}

#pragma mark - getters
- (ZHNJSBoxEngine *)jsBox {
    if (_jsBox == nil) {
        _jsBox = [[ZHNJSBoxEngine alloc]init];
        _jsBox.delegate = self;
    }
    return _jsBox;
}
@end
