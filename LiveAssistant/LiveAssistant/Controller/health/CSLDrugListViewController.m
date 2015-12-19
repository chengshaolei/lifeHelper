//
//  CSLDrugListViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugListViewController.h"
#import "CSLDrugListModel.h"
#import "CSLDrugListCell.h"
#import "CSLDrugDetailController.h"

#define DrugLiseCell @"DrugLiseCell"

@interface CSLDrugListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *DrugList;
-(void) controllerInit;//初始化
-(void) loadData;//加载数据
@end

@implementation CSLDrugListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self controllerInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) controllerInit{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"药品大全";
    self.isLoadIndicator = YES;//显示加载指示器
    [self.DrugList registerNib:[UINib nibWithNibName:@"CSLDrugListCell" bundle:nil] forCellReuseIdentifier:DrugLiseCell];
    [self loadData];
}

//加载数据
-(void) loadData{
    self.isLoadIndicator = YES;
    [self showIndicatorInView:self.parentViewController.view isDisplay:YES];
    [self JHRequestWithAPPid:@"148" method:@"GET" url:JH_MedicineList_URL paras:@{@"key":@"4dc428e62a3a75334fbcd02e4d4f485a",@"cName":_drugType}];
}

//数据解析
-(void) parserData:(id)data{
    NSString * status = data[@"reason"];
    if ([status isEqualToString:@"success!"]) {//成功
        NSArray * list = data[@"result"][@"list"];
        if (list&&list.count>0) {
            NSArray* tmp = [CSLDrugListModel arrayOfModelsFromDictionaries:list];
            if (tmp&&tmp.count>0) {
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray:tmp];
                [self.DrugList reloadData];
            }
        }
    }
    [self showIndicatorInView:self.parentViewController.view isDisplay:NO];
}

#pragma mark-------表的代理----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLDrugListCell * cell = [tableView dequeueReusableCellWithIdentifier:DrugLiseCell];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLDrugListModel *model = self.dataSource[indexPath.row];
    CSLDrugDetailController * detailController = [[CSLDrugDetailController alloc] init];
    detailController.drugInfo = model;
    [self.navigationController pushViewController:detailController animated:YES];
}
@end
