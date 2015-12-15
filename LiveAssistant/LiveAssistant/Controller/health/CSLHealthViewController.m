//
//  CSLHealthViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLHealthViewController.h"
#import "CSLPositionModel.h"

@interface CSLHealthViewController ()<UITableViewDataSource,UITableViewDelegate>
-(void) getData;//请求数据
@end

@implementation CSLHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------数据请求和解析------------------
-(void) getData{
    //查询位置信息
    //    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopPostion_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3"}];
    
    //查询药店列表
    //    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopList_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":@1}];
    
    //查询药店详情
    [self JHRequestWithAPPid:@"144" method:@"GET" url:JH_ShopInfo_URL paras:@{@"key":@"875cdfc5776231020026c6dceeb387b3",@"id":@101082}];
}

//数据解析
-(void) parserData:(id)data{
    if([data  isKindOfClass:[NSDictionary class]]){
        NSLog(@"%@",data);
        NSLog(@"%@",data[@"reason"]);
        NSDictionary * resultDict = data[@"result"];
        //        NSArray * tan =resultDict[@"tngou"];
        //        NSArray * arr = [CSLPositionModel arrayOfModelsFromDictionaries:tan];
        //        NSLog(@"%@",arr);
        //        NSArray * arr = [CSLDrugstoreModel arr]
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
    return nil;
}


@end
