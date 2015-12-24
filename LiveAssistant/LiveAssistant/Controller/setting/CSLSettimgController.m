//
//  CSLSettomgController.m
//  LiveAssistant
//
//  Created by csl on 15/12/22.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLSettimgController.h"

@interface CSLSettimgController ()<UITableViewDataSource,UITableViewDelegate>
-(void) settingInit;//数据初始化
@end

@implementation CSLSettimgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) settingInit{
    NSArray * controllers = @[@"我的收藏",@"清除缓存",@"关于我们"];
    [self.dataSource addObjectsFromArray:@[@"我的收藏",@"清除缓存",@"关于我们"]];
}


#pragma mark-----------UITableViewDatasource-------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
