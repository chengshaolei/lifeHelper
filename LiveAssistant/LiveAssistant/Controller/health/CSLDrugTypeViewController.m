//
//  CSLDrugTypeViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugTypeViewController.h"
#import "CSLDrugTypeLeftController.h"
#import "CSLDrugTypeDetailViewController.h"

#import "MBProgressHUD.h"

@interface CSLDrugTypeViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchDrug;
-(void) setupUI;//创建界面
-(void) layoutSubView;//自动布局
//-(void) loadData;//加载数据
@end

@implementation CSLDrugTypeViewController
{
//    CSLDrugTypeLeftController * _LeftController;
//    CSLDrugTypeDetailViewController * _rightController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.dataSource = [NSMutableArray array];
    
    [self setupUI];
//    [self loadData];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self layoutSubView];
}
-(void) setupUI{
    if (!_LeftController) {
        _LeftController = [[CSLDrugTypeLeftController alloc] init];
    }
    if (!_rightController) {
        _rightController = [[CSLDrugTypeDetailViewController alloc] init];
    }
    
    //添加自控制器
    [self addChildViewController:_LeftController];
    [self addChildViewController:_rightController];
    
    //设置左边的控制器view的frame
    _LeftController.view.frame = CGRectMake(0, self.searchDrug.frame.size.height, self.view.frame.size.width/2, self.view.frame.size.height-self.searchDrug.frame.size.height);
    [self.view addSubview:_LeftController.view];
    
    //设置右边的控制器view的frame
    _rightController.view.frame = CGRectMake(self.view.frame.size.width/2, self.searchDrug.frame.size.height, self.view.frame.size.width/2, self.view.frame.size.height-self.searchDrug.frame.size.height);
    [self.view addSubview:_rightController.view];
    
}

-(void) layoutSubView{
    //左视图
    UIView * leftView = _LeftController.view;
    leftView.layer.borderWidth = 1;
    leftView.layer.borderColor = [UIColor grayColor].CGColor;
    leftView.
    translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchDrug]-5-[leftView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchDrug,leftView)]];
    
    //右视图
    UIView * rightView = _rightController.view;
    rightView.layer.borderWidth = 1;
    rightView.layer.borderColor = [UIColor grayColor].CGColor;
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchDrug]-5-[rightView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchDrug,rightView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftView(110)]-1-[rightView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftView,rightView)]];
}

#pragma mark----------数据请求处理------------
//-(void) loadData{//数据请求
//    [self JHRequestWithAPPid:@"148" method:@"GET" url:JH_MedicineType_URL paras:@{@"key":@"4dc428e62a3a75334fbcd02e4d4f485a"}];
//}
//-(void) parserData:(id)data{//重载数据解析
//    [super parserData:nil];
//    NSArray *temp = data[@"result"][@"list"];
//    NSArray *list = [CSLDrugTypeModel arrayOfModelsFromDictionaries:temp];
//    [self.dataSource addObjectsFromArray:list];
//    
//}
-(void) showIndicator:(BOOL)show{
    if (!self.isLoadIndicator) {//如果加载标志为假，不显示加载标志
        return;
    }
    if (show) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}
@end
