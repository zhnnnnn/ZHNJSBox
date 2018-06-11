//
//  ViewController.m
//  ZHNJSBox
//
//  Created by 张辉男 on 2018/4/25.
//  Copyright © 2018年 zhn. All rights reserved.
//

#import "ViewController.h"
#import "ZHNJSBoxEngine.h"
#import "Masonry.h"
#import "ZHNJSBoxViewController.h"
#import "ZHNJSBoxJSContextManager.h"
#import "ZHNJSEditorController.h"
#import "ZHNJSBoxScriptCell.h"
#import "SettingViewController.h"

#define KBackColor [UIColor colorWithRed:238/255.0 green:241/255.0 blue:241/255.0 alpha:1]
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ZHNJSBoxScriptCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZHNJSBoxEngine *jsBox;
@property (nonatomic, copy) NSArray *scriptNames;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(settingAction)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    self.scriptNames = @[@"v2ex",@"parities",@"kaomoji",@"tipcalcuator"];
}

#pragma mark - target action
- (void)settingAction {
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scriptNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHNJSBoxScriptCell *cell = [ZHNJSBoxScriptCell createCellWithTableView:tableView];
    cell.scriptName = self.scriptNames[indexPath.row];
    cell.backgroundColor = KBackColor;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *path = [[NSBundle mainBundle] pathForResource:self.scriptNames[indexPath.row] ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    ZHNJSEditorController *controller = [[ZHNJSEditorController alloc] init];
    controller.script = script;
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)ZHNJSBoxScriptCellSelectToRun:(NSString *)scriptName {
    NSString *path = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    BOOL haveRender = [ZHNJSBoxEngine isScriptHaveRender:script];
    if (haveRender) {
        ZHNJSBoxViewController *controller = [ZHNJSBoxViewController controllerWithScript:script];
        [self presentViewController:controller animated:YES completion:nil];
    }else {
        [self.jsBox evaluateScript:script];
    }
}

#pragma mark - getters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = KBackColor;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

- (ZHNJSBoxEngine *)jsBox {
    if (_jsBox == nil) {
        _jsBox = [[ZHNJSBoxEngine alloc]init];
    }
    return _jsBox;
}
@end
