//
//  CSLToolViewController.m
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLToolViewController.h"
#import "CSLScanViewController.h"
#import "CSLExpressViewController.h"
#import "CSLFlashlightViewController.h"
#import "CSLVocabularyController.h"
#import "CSLTermController.h"
#import "CSLTranslationController.h"
#import "CSLWeatherController.h"
#import "CSLAlertViewController.h"

#define SCANBUTTONTAG   10//扫描按钮tag值
@interface CSLToolViewController ()

@end

@implementation CSLToolViewController
{
    NSArray * _childControllers;//控制器类名数组
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _childControllers = @[@"CSLScanViewController",@"CSLExpressViewController",@"CSLFlashlightViewController",@"CSLVocabularyController",@"CSLTermController",@"CSLTranslationController",@"CSLWeatherController",@"CSLAlertViewController"];//实例化
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;//恢复导航栏
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//二维码扫描
- (IBAction)scanCode:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}

//快递
- (IBAction)express:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}

//手电筒
- (IBAction)light:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}

//新华字典
- (IBAction)chineseExplain:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}
- (IBAction)termExplain:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}
- (IBAction)translate:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}

- (IBAction)wheather:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}
- (IBAction)alert:(id)sender {
    //取得按钮的tag值
    NSUInteger index = ((UIButton*)sender).tag;
    [self pushController:index];
}


//推出下一层控制器
-(void) pushController:(NSUInteger)index{
    //取得控制器类名
    NSString * viewControllerClassName = _childControllers[index-10];
    
    //取得控制器所属类
    Class controllerClass = NSClassFromString(viewControllerClassName);
    UIViewController * vc = [[controllerClass alloc] init];//实例化控制器
    
    //如果是扫描窗口，隐藏tabbar
    if (index==SCANBUTTONTAG) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];//推出控制器
}
@end
