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

@interface CSLDrugTypeViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchDrug;
-(void) setupUI;//创建界面
-(void) layoutSubView;//自动布局
@end

@implementation CSLDrugTypeViewController
{
    CSLDrugTypeLeftController * _LeftController;
    CSLDrugTypeDetailViewController * _rightController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
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
        _LeftController.view.backgroundColor = [UIColor redColor];
    }
    if (!_rightController) {
        _rightController = [[CSLDrugTypeDetailViewController alloc] init];
        _rightController.view.backgroundColor = [UIColor blackColor];
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
    leftView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchDrug]-1-[leftView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchDrug,leftView)]];
    
    //右视图
    UIView * rightView = _rightController.view;
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchDrug]-1-[rightView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_searchDrug,rightView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftView(150)]-1-[rightView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftView,rightView)]];
}
@end
