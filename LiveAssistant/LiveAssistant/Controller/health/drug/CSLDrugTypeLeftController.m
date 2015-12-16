//
//  CSLDrugTypeLeftController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugTypeLeftController.h"

@interface CSLDrugTypeLeftController ()<UITableViewDataSource,UITableViewDelegate>
-(void) loadData;//加载数据
@end

@implementation CSLDrugTypeLeftController
{
    IBOutlet UITableView * tableView;
    NSMutableArray * _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//加载数据
-(void) loadData{
    [self JHRequestWithAPPid:@"148" method:@"GET" url:JH_MedicineType_URL paras:@{@"key":@"4dc428e62a3a75334fbcd02e4d4f485a"}];
}

//解析数据
-(void) parserData:(id)data{
    NSDictionary * result = data[@"result"];
    if (result&&result.count>0) {
        NSArray * list = result[@"list"];
        NSLog(@"%@",list);
        
    }
}

#pragma mark-------表的代理------
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

@end
