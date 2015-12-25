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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) settingInit{
    self.navigationItem.title = NSLocalizedString(@"setting", nil);
    _controllers = @[@"CSLFavortateController",[NSNull null],[NSNull null],@"CSLAboutUsController"];
    [self.dataSource addObjectsFromArray:@[@"我的收藏",@"清除缓存",@"版本检测",@"关于我们"]];
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
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(0, 0, 60, 30);
    [loginBtn setTitle:@"未登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [_protraitView addSubview:loginBtn];
    
    
    
    //适配
    portraitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[portraitBtn(60)]-10-[loginBtn(30)]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(portraitBtn,loginBtn)]];
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-130-[portraitBtn(60)]-130-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(portraitBtn)]];
    [_protraitView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-130-[loginBtn(60)]-130-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginBtn)]];
    
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
    [self.navigationController pushViewController:loginController animated:YES];
}

@end
