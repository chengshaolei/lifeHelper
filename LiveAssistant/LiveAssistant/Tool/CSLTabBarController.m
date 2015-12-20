//
//  CSLTabBarController.m
//  HomeTool
//
//  Created by csl on 15/12/7.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "CSLTabBarController.h"
@interface CSLTabBarController()
@end

@implementation CSLTabBarController

//初始化
-(instancetype)init{
    if (self=[super init]) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return self;
}

//创建tabbaritem
-(void) addItem:(NSString*)title normalImage:(UIImage*)normal highLightImage:(UIImage*)highLight controller:(NSString*)controllerName {
    
    //创建tabBarItem
    normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    highLight = [highLight imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:normal selectedImage:highLight];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    
    //得到控制器类
    Class controllerClass = NSClassFromString(controllerName);
    
    //创建控制器
    UIViewController *  controller = [[controllerClass alloc] init];
    controller.navigationItem.title = title;//设置导航栏标题
    
    //创建导航栏
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    //设置item
    controller.tabBarItem = item;
//    controller.tabBarController.tabBar.barTintColor = ;
    self.tabBar.barTintColor =[UIColor colorWithRed:121.0/255 green:200.0/255 blue:231.0/255 alpha:1];
    
    //将控制器加入数组
    [_controllers addObject:navigationController];
    
}
@end
