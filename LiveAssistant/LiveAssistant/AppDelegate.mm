//
//  AppDelegate.m
//  HomeTool
//
//  Created by csl on 15/12/7.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "AppDelegate.h"
#import "CSLTabBarController.h"

#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "CSLConstant.h"

@interface AppDelegate ()
//搭建app的框架
-(void) createAppFrame;
-(void) initApp;//初始化
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //搭建系统框架
    [self createAppFrame];
    [self initApp];//系统初始化
//    
//    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//创建标签栏
-(void) createAppFrame{
    //创建标签栏
    CSLTabBarController * tabBarController = [[CSLTabBarController alloc] init];
    //增加工具标签
    [tabBarController addItem:NSLocalizedString(@"tabbar_tool",nil) normalImage:[UIImage imageNamed:@"tool.png"] highLightImage:[UIImage imageNamed:@"tool.png"] controller:@"CSLToolViewController"];
    
    //增加健康标签
    [tabBarController addItem:NSLocalizedString(@"tabbar_health",nil) normalImage:[UIImage imageNamed:@"health.png"] highLightImage:[UIImage imageNamed:@"health.png"] controller:@"CSLHealthViewController"];
    
    //增加聊天室标签
    [tabBarController addItem:NSLocalizedString(@"tabbar_chatroom",nil) normalImage:[UIImage imageNamed:@"chatroom.png"] highLightImage:[UIImage imageNamed:@"chatroom.png"] controller:@"CSLChatroomViewController"];
    
    //设置标签栏的viewControllers数组
    tabBarController.viewControllers = tabBarController.controllers;
    
    //设置window的rootviewcontroller
    self.window.rootViewController = tabBarController;
}

//各种初始化
-(void) initApp{
    //聚合初始化
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:JHAPPID];
    //环信初始化
//    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1000phonemobile#chatdemo" apnsCertName:@"MyPushDemo20151125"];
}
@end
