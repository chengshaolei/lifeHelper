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

#define SettingCellReuse @"SettingTableViewCell"

@interface CSLSettingController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *settingTable;
-(void) settingInit;//数据初始化
-(void) setupHeaderView;//设置表的头视图
@end

@implementation CSLSettingController
{
    NSArray * _controllers;
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
    _controllers = @[@"CSLFavortateController",[NSNull null],@"CSLAboutUsController"];
    [self.dataSource addObjectsFromArray:@[@"我的收藏",@"清除缓存",@"关于我们"]];
    [self.settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:SettingCellReuse];
}

-(void) setupHeaderView{
    
}

#pragma mark-----------UITableViewDatasource-------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:SettingCellReuse];
    cell.textLabel.text = self.dataSource[indexPath.row];
    if (1!=indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

// 行选中
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1==indexPath.row) {
        CSLClearCache * CacheManager = [[CSLClearCache alloc] init];
        float size = [CacheManager clearCache];
        NSString *str = [NSString stringWithFormat:@"%@ %.2fM",NSLocalizedString(@"cache clean", nil), size];
        [Auxiliary alertWithTitle:nil message:str button:1 done:nil];
    }
    else{
        Class controllerClass = NSClassFromString(_controllers[indexPath.row]);
        UIViewController *vc = [[controllerClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
