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
#import "CSLDrugTypeViewController.h"

@interface CSLHealthMainController ()

@end

@implementation CSLHealthMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CSLHealthViewController *drugShop = [[CSLHealthViewController alloc] init];
    drugShop.title = @"药房";
    
    CSLDrugTypeViewController * drugType = [[CSLDrugTypeViewController alloc] init];
    drugType.title = @"药品";
    
    SCNavTabBarController * navTabBarController = [[SCNavTabBarController alloc] initWithShowArrowButton:NO];
    navTabBarController.showArrowButton = NO;
    navTabBarController.subViewControllers = @[drugShop,drugType];
    navTabBarController.navTabBarColor = [UIColor colorWithRed:121.0/255 green:200.0/255 blue:231.0/255 alpha:1];
    [navTabBarController addParentController:self];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
