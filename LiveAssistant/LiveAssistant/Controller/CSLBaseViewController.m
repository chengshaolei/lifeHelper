//
//  CSLBaseViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLBaseViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface CSLBaseViewController ()
-(void) dataInit;//数据初始化
-(void) showIndicator:(BOOL)show;//是否显示指示器
@end

@implementation CSLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.dataSource = nil;//销毁数据源
}


//初始化数据源
-(void) dataInit{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
}

//数据请求
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict{
    [self showIndicator:YES];
    if ([method isEqualToString:@"GET"]) {
        [CSLNetRequest get:urlString complete:^(id data) {
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    else{
        [CSLNetRequest post:urlString para:dict complete:^(id data) {
            [self parserData:data];
        } fail:^(NSError *error) {
            NSLog(@"%@",error.description);
        }];
    }
}


//聚合数据请求
-(void) JHRequestWithAPPid:(NSString*)appid method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict{
    [self showIndicator:YES];
    [CSLNetRequest JHRequestAPPId:appid Method:method url:urlString paras:dict success:^(id reponeseData) {
        [self parserData:reponeseData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

//子类是实现
-(void) parserData:(id)data{
    [self showIndicator:NO];
}

-(void) showIndicator:(BOOL)show{
    if (show) {
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    }
    else{
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }
}
@end
