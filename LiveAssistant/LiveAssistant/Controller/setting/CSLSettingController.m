//
//  CSLSettingController.m
//  LiveAssistant
//
//  Created by csl on 15/12/22.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLSettingController.h"
#import "CSLAboutUsController.h"
#import "CSLFavortateController.h"
#import "CSLClearCache.h"
#import "Auxiliary.h"
#import "CSLLoginViewController.h"


#define SettingCellReuse @"SettingTableViewCell"
#define MYAppID @"1070708005"
@interface CSLSettingController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingTable;
-(void) settingInit;//数据初始化
-(void) setupHeaderView;//设置表的头视图
@end

@implementation CSLSettingController
{
    NSArray * _controllers;
    UIImageView * _protraitView;//头像
    UIButton * _loginBtn;//登录按钮
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _controllers = nil;
    _protraitView = nil;
}


-(void) settingInit{
    self.navigationItem.title = NSLocalizedString(@"setting", nil);
    _controllers = @[@"CSLFavortateController",[NSNull null],[NSNull null],@"CSLAboutUsController"];

    [self.dataSource addObjectsFromArray:@[NSLocalizedString(@"Favorite", nil),NSLocalizedString(@"Clear Cache", nil),NSLocalizedString(@"Version Check", nil),NSLocalizedString(@"About us", nil)]];
    [self.settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:SettingCellReuse];
    [self setupHeaderView];
}

-(void) setupHeaderView{
    //设置头视图
    _protraitView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 160)];
    _protraitView.image = [UIImage imageNamed:@"headerbg"];
    _protraitView.userInteractionEnabled = YES;
    self.settingTable.tableHeaderView = _protraitView;
    
    //设置头像视图
    UIButton * portraitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    portraitBtn.frame = CGRectMake(0, 0, 60, 60);
    portraitBtn.layer.cornerRadius = 30;
    portraitBtn.layer.masksToBounds = YES;
    [portraitBtn setImage:[UIImage imageNamed:@"portrait"] forState:UIControlStateNormal];
    [_protraitView addSubview:portraitBtn];
    
    //登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(0, 0, 80, 30);
    [_loginBtn setTitle:NSLocalizedString(@"Not Login", nil) forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [_protraitView addSubview:_loginBtn];
    
    //适配
    portraitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[portraitBtn(60)]-10-[_loginBtn(30)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(portraitBtn,_loginBtn)]];
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-130-[portraitBtn(60)]-130-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(portraitBtn)]];
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-110-[_loginBtn(80)]-110-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_loginBtn)]];
    
}

#pragma mark-----------UITableViewDatasource-------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SettingCellReuse];
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (1!=indexPath.row&&2!=indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

// 行选中
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1==indexPath.row) {//清除缓存
        CSLClearCache * CacheManager = [[CSLClearCache alloc] init];
        float size = [CacheManager clearCache];
        NSString *str = [NSString stringWithFormat:@"%@ %.2fM",NSLocalizedString(@"cache clean", nil), size];
        [Auxiliary alertWithTitle:nil message:str button:1 done:nil];
    }
    else if(2==indexPath.row){//版本更新
        [Auxiliary checkVersion:MYAppID];
    }
    else{
        Class controllerClass = NSClassFromString(_controllers[indexPath.row]);
        UIViewController *vc = [[controllerClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void) login:(UIButton*)sender{
    CSLLoginViewController * loginController = [[CSLLoginViewController alloc] init];
    __weak CSLLoginViewController* weakVc = loginController;
    __weak UIButton * weakBtn = _loginBtn;
    weakVc.loginCallBack = ^(BOOL isLogin){//修改标题
        [weakBtn setTitle:NSLocalizedString(@"login", nil) forState:UIControlStateNormal];
    };

    [self.navigationController pushViewController:loginController animated:YES];
}

@end
