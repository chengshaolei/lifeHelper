//
//  CSLExpressViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLExpressViewController.h"
#import "CSLConstant.h"
#import "CSLNetRequest.h"
#import "CSLDownListView.h"

@interface CSLExpressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *expressOrderTextField;
@property (strong, nonatomic)  CSLDownListView *downlistView;
-(void) initDownlistView;//初始化下拉列表框
@end

@implementation CSLExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initDownlistView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    CGRect frame = self.expressOrderTextField.frame;
    self.downlistView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+10, frame.size.width, 40);
}

//数据请求
-(void) requestData:(NSString*)urlString para:(NSDictionary*)dict{
    [CSLNetRequest post:urlString para:dict complete:^(id data) {
        NSLog(@"%@",data);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void) initDownlistView{
    CGRect frame = self.expressOrderTextField.frame;
    self.downlistView = [[CSLDownListView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+5, frame.size.width, 40)];
    [self.view addSubview:self.downlistView];
    
    __weak CSLExpressViewController* weakSelf = self;
    self.downlistView.findNo = ^(NSString*expressNO,NSString*company){
        [weakSelf requestData:URL_EXPRESS para:@{@"apikey":@"6eb360953ca88ffef4ea260a23c54fda",@"keyword":expressNO,@"kuaidicompany":company}];
    };
    
    self.downlistView.dataSource = [NSMutableArray arrayWithArray:@[@"顺丰",@"ems",@"申通",@"圆通",@"中通",@"如风达",@"韵达",@"天天",@"汇通",@"全峰",@"德邦",@"宅急送",@"速尔",@"优速"]];
    
}
@end
