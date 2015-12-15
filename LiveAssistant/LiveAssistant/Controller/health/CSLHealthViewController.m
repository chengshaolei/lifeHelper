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

#define ShopListCellReuse @"ShopListCellReuse"

@interface CSLHealthViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) getData;//请求数据
-(void) initData;//初始化
@end

@implementation CSLHealthViewController
{
    NSUInteger _pages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //数据请求
    [self getData];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initData{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CSLShopListCell" bundle:nil] forCellReuseIdentifier:ShopListCellReuse];
    
    //初始化
    _pages = 1;
}

#pragma mark ------------------------数据请求和解析------------------
-(void) getData{
    //查询位置信息
//    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopPostion_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3"}];
    
    //查询药店列表
    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopList_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":[NSNumber numberWithUnsignedLong:_pages]}];
    
    //查询药店详情
//    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopInfo_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":@101082}];
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


@end
