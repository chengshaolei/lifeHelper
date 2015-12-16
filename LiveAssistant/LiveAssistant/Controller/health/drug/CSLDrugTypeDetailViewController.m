//
//  CSLDrugTypeDetailViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugTypeDetailViewController.h"

@interface CSLDrugTypeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
-(void) loadData;//加载数据
@end

@implementation CSLDrugTypeDetailViewController{
    IBOutlet UITableView* myTableView;
    NSMutableArray * _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _datas = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(void) loadData{
    [self JHRequestWithAPPid:@"148" method:@"GET" url:@"" paras:nil];
}
-(void) parserData:(id)data{
    NSLog(@"%@",data);
}
@end
