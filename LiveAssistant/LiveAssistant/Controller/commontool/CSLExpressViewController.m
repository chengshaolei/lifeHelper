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
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UITextField *expressOrderTextField;
@property (strong, nonatomic) IBOutlet  CSLDownListView *downlistView;
@property(nonatomic,strong)NSMutableArray* dataSource;//表格的数据源
-(void) initDownlistView;//初始化下拉列表框

@end

@implementation CSLExpressViewController
{
    IBOutlet UITableView * _tableView;
}
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initDownlistView];
//    [self downlistViewAutolayout];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_expressOrderTextField]-10-[_downlistView(174)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_expressOrderTextField,_downlistView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_companyLabel]-2-[_downlistView]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_companyLabel,_downlistView)]];
}

-(void) viewWillLayoutSubviews{
    CGRect frame = self.expressOrderTextField.frame;
    self.downlistView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+5, frame.size.width, 40);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//数据请求
-(void) requestData:(NSString*)urlString para:(NSDictionary*)dict{
    [CSLNetRequest post:urlString para:dict complete:^(id data) {
        
        NSMutableDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



-(void) initDownlistView{
    CGRect frame = self.expressOrderTextField.frame;
    self.downlistView = [[CSLDownListView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+5, frame.size.width, 40)];
    [self.view addSubview:self.downlistView];
    self.downlistView.translatesAutoresizingMaskIntoConstraints = NO;
    
    __weak CSLExpressViewController * weakSelf = self;
    self.downlistView.done = ^(){
        [weakSelf.expressOrderTextField endEditing:YES];
    };
    
    //初始化下拉列表的数据源
    self.downlistView.dataSource = [NSMutableArray arrayWithArray:@[@"顺丰",@"ems",@"申通",@"圆通",@"中通",@"如风达",@"韵达",@"天天",@"汇通",@"全峰",@"德邦",@"宅急送",@"速尔",@"优速"]];
    
}
- (IBAction)findExpressNo:(id)sender {
    if (self.expressOrderTextField.text.length<=0 || self.downlistView.selectedItem==nil) {
        return;
    }
    [self requestData:URL_EXPRESS para:@{@"apikey":@"6eb360953ca88ffef4ea260a23c54fda",@"keyword":self.expressOrderTextField.text,@"kuaidicompany":self.downlistView.selectedItem}];
}

-(NSMutableArray*) dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
