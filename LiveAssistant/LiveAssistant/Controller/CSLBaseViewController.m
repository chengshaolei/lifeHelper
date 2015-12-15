//
//  CSLBaseViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLBaseViewController.h"

@interface CSLBaseViewController ()
-(void) dataInit;//数据初始化
@end

@implementation CSLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化数据源
-(void) dataInit{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
}

//数据请求
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict{
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

-(void) JHRequestWithAPPid:(NSString*)appid method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict{
    [CSLNetRequest JHRequestAPPId:appid Method:method url:urlString paras:dict success:^(id reponeseData) {
        [self parserData:reponeseData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

//子类是实现
-(void) parserData:(id)data{
    
}
@end
