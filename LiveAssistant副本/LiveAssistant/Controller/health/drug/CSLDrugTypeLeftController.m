//
//  CSLDrugTypeLeftController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugTypeLeftController.h"
#import "CSLDrugTypeModel.h"
#import "CSLDrugTypeViewController.h"
#import "CSLDrugTypeDetailViewController.h"


#define DrugTypeCellReuse @"DrugTypeCellReuse"

@interface CSLDrugTypeLeftController ()<UITableViewDataSource,UITableViewDelegate>
-(void) controllerInit;//初始化
-(void) loadData;//加载数据
@end

@implementation CSLDrugTypeLeftController
{
    IBOutlet UITableView * _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self controllerInit];//初始化
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
-(void) controllerInit{
    if (!self.dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.separatorColor = [UIColor grayColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DrugTypeCellReuse];
}

//加载数据
-(void) loadData{
    [self showIndicatorInView:self.view isDisplay:YES];
    [self JHRequestWithAPPid:@"148" method:@"GET" url:JH_MedicineType_URL paras:@{@"key":@"4dc428e62a3a75334fbcd02e4d4f485a"}];
}

//解析数据
-(void) parserData:(id)data{
    NSDictionary * result = data[@"result"];
    if (result&&result.count>0) {
        NSArray *temp = result[@"list"];
        NSArray *list = [CSLDrugTypeModel arrayOfModelsFromDictionaries:temp];
        [self.dataSource addObjectsFromArray:list];
        [_tableView reloadData];//刷新显示
    }
    [self showIndicatorInView:self.view isDisplay:NO];
}

#pragma mark-------表的代理------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DrugTypeCellReuse];
    CSLDrugTypeModel * model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.title;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLDrugTypeViewController * mainController = (CSLDrugTypeViewController *)self.parentViewController;
    CSLDrugTypeModel * model =  self.dataSource[indexPath.row];
    [mainController.rightController reloadData:model.title];
}
@end
