//
//  CSLDrugTypeDetailViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugTypeDetailViewController.h"
#import "CSLDrugTypeModel.h"
#import "CSLDrugListViewController.h"


#define DrugTypeDetailCell @"DrugTypeDetailCell"
@interface CSLDrugTypeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CSLDrugTypeDetailViewController{
    IBOutlet UITableView* myTableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    [myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DrugTypeDetailCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DrugTypeDetailCell];
    cell.textLabel.text = [self.dataSource[indexPath.row] title];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}
-(void) reloadData:(NSString*)type{
    [self JHRequestWithAPPid:@"148" method:@"GET" url:JH_MedicineTypeSearch_URL paras:@{@"key":@"4dc428e62a3a75334fbcd02e4d4f485a",@"name":type}];
}
//选中打开药品列表
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CSLDrugListViewController * listController = [[CSLDrugListViewController alloc] init];
    listController.drugType = [self.dataSource[indexPath.row] title];//将药品类别的名称传过去
    [self.parentViewController.navigationController pushViewController:listController animated:YES];
}

-(void) parserData:(id)data{
    NSLog(@"%@",data);
    [self.dataSource removeAllObjects];
    if ([data[@"reason"] isEqualToString:@"success!"]) {
        NSArray * tmp = data[@"result"][@"list"];
        if (tmp&&tmp.count>0) {
            NSArray * list = [CSLDrugTypeModel arrayOfModelsFromDictionaries:tmp];
            [self.dataSource addObjectsFromArray:list];
            [myTableView reloadData];
        }
    }
}
@end
