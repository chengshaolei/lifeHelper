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
-(void) showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show;//是否显示指示器
@end

@implementation CSLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:121.0/255 green:200.0/255 blue:231.0/255 alpha:1];
    }
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
    _isLoadIndicator = YES;//默认加载数据显示加载标志
}

-(void) requestType:(RequestType)type method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict{
    switch (type) {
        case NormalRequest:
            [self request:method url:urlString para:dict];
            break;
        case JHRequest:
        {
            NSString * appid = dict[@"appid"];
            NSMutableDictionary * mdict  = [[NSMutableDictionary alloc] init];
            [mdict addEntriesFromDictionary:dict];
            [mdict removeObjectForKey:@"appid"];
            [self JHRequestWithAPPid:appid method:method url:urlString paras:mdict];
        }
        default:
            break;
    }
   
}

//数据请求
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict{
//    [self showIndicator:YES];
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

-(void)request: (NSString*)urlStr  {
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    
    //设置header
    [request addValue: kBadiDu_wheather_Apikey forHTTPHeaderField: @"apikey"];
    
    //请求
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"HttpResponseCode:%ld", responseCode);
                                   NSLog(@"HttpResponseBody %@",responseString);
                                   [self parserData:data];
                               }
                           }];
}

//聚合数据请求
-(void) JHRequestWithAPPid:(NSString*)appid method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict{
//    [self showIndicator:YES];
    [CSLNetRequest JHRequestAPPId:appid Method:method url:urlString paras:dict success:^(id reponeseData) {
        [self parserData:reponeseData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

//子类是实现
-(void) parserData:(id)data{
//    [self showIndicator:NO];
}

-(void) showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show{
    if (!_isLoadIndicator) {//如果加载标志为假，不显示加载标志
        return;
    }
    if (show) {
        [MBProgressHUD showHUDAddedTo:parentView animated:YES];
    }
    else{
        [MBProgressHUD hideHUDForView:parentView animated:YES];
    }
}
@end
