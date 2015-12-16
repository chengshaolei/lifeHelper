//
//  CSLHealthMainController.m
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLHealthMainController.h"
#import "CSLHealthViewController.h"
#import "SCNavTabBarController.h"

@interface CSLHealthMainController ()

@end

@implementation CSLHealthMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CSLHealthViewController *drugShop = [[CSLHealthViewController alloc] init];
    drugShop.title = @"药房";
    SCNavTabBarController * navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[drugShop];
    navTabBarController.showArrowButton = YES;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    [navTabBarController addParentController:self];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
