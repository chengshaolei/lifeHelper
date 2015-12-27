//
//  CSLHealthViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLHealthViewController.h"
#import "CSLPositionModel.h"
#import "CSLShopListModel.h"
#import "CSLShopListCell.h"
#import "CSLShopDetailViewController.h"
#import "MJRefresh.h"

#define ShopListCellReuse @"ShopListCellReuse"

@interface CSLHealthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) getData;//请求数据
-(void) initData;//初始化
@end

@implementation CSLHealthViewController
{
    NSUInteger _pages;
    NSUInteger amount;//总记录数
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    //数据请求
    //[self getData];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void) initData{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CSLShopListCell" bundle:nil] forCellReuseIdentifier:ShopListCellReuse];
    self.tableView.rowHeight = 80;
    
    //初始化
    _pages = 1;
    
    //下拉刷新
    __weak CSLHealthViewController * weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //初始化页数为1，删除数组数据
        _pages = 1;
        weakSelf.isLoadIndicator = NO;
        [weakSelf.dataSource removeAllObjects];//清除数据
        [weakSelf getData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    //上提刷新
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isLoadIndicator = NO;
        [weakSelf getData];
    }];
    self.tableView.mj_footer = footer;
}

#pragma mark ------------------------数据请求和解析------------------
-(void) getData{
    //查询位置信息
//    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopPostion_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3"}];
    
    //查询药店列表
    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopList_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":[NSNumber numberWithUnsignedLong:_pages]}];
    _pages++;//页数自增
}

//数据解析
-(void) parserData:(id)data{
    if([data  isKindOfClass:[NSDictionary class]]){
        NSDictionary * resultDict = data[@"result"];
        NSArray * tan =resultDict[@"list"];
        if ([tan isEqual:[NSNull null]]) {
            return;
        }
        NSArray * arr = [CSLShopListModel arrayOfModelsFromDictionaries:tan];
        
        //如果数组是空
        if ([arr isEqual:[NSNull null]]) {
            return;
        }
        
        [self.dataSource addObjectsFromArray:arr];
        [self.tableView reloadData];
    }
    else{
        __autoreleasing NSError * error;
        NSMutableDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (result) {
            NSLog(@"%@",result);
        }
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [super parserData:nil];
}

#pragma mark----------------------UITableViewDatasource/Delegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLShopListCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopListCellReuse];
    CSLShopListModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLShopListModel * model = self.dataSource[indexPath.row];
    
    //实例化详细页面
    CSLShopDetailViewController * detailController = [[CSLShopDetailViewController alloc] init];
    detailController.compandId = model.id;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
