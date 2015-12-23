//
//  CSLExpressDetailController.m
//  LiveAssistant
//
//  Created by csl on 15/12/23.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLExpressDetailController.h"
#import "CSLConstant.h"
#import "CSLExpressModel.h"
#import "CSLNetRequest.h"
#import "MBProgressHUD.h"
#import "Auxiliary.h"


#define ExpressCellReuse @"ExpressCellReuse"

@interface CSLExpressDetailController ()
@property(nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation CSLExpressDetailController
{
    NSMutableArray * _rowHeights;//行高数组
}
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快递详情";
    [self loadDataWithCompany:self.shortName no:self.expressNo];
    self.dataSource = [NSMutableArray array];
    _rowHeights = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ExpressCellReuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ExpressCellReuse];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] valueForKey:@"context"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = [self.dataSource[indexPath.row] valueForKey:@"time"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [_rowHeights[indexPath.row] floatValue];
}

#pragma mark------数据请求-----------------
-(void) loadDataWithCompany:(NSString*)comp no:(NSString*)num{
    NSString * url = [NSString stringWithFormat:kBaiDu_Express_URL,comp,num];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];//显示加载指示器
    [CSLNetRequest get:url complete:^(id data) {
        [self parserData:data];
    } fail:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(void) parserData:(id)data{
    [MBProgressHUD hideHUDForView:self.view animated:NO];//隐藏加载指示器
    
    __autoreleasing NSError * error;
    CSLExpressModel * model = [[CSLExpressModel alloc] initWithData:data error:&error];
    if (!error) {
        NSLog(@"%@",model);
    }
    NSArray * result = model.data;
    NSLog(@"%@",result);
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:result];
    [self dynamicHeight];
    [self.tableView reloadData];
}

-(void) dynamicHeight{
    for (CSLExpressStep* step in self.dataSource) {
        float height = [Auxiliary dynamicHeightWithString:[step valueForKey:@"context"] width:self.tableView.frame.size.width attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        float timeHeight =[Auxiliary dynamicHeightWithString:[step valueForKey:@"time"] width:self.tableView.frame.size.width attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        [_rowHeights addObject:[NSNumber numberWithFloat:height+timeHeight+15]];
    }
}
@end
