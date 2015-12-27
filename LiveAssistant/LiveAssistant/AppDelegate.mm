//
//  AppDelegate.m
//  HomeTool
//
//  Created by csl on 15/12/7.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "AppDelegate.h"
#import "CSLTabBarController.h"
#import "Auxiliary.h"
#import "UMSocial.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "CSLConstant.h"
#import "APService.h"

@interface AppDelegate ()
//搭建app的框架
-(void) createAppFrame;
-(void) initApp:(NSDictionary *)launchOptions;//初始化
-(void) jpush:(NSDictionary *)launchOptions;//极光推送初始化
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //搭建系统框架
    [self createAppFrame];
    [self initApp:launchOptions];//系统初始化
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //反馈给服务器，告诉官方APNs服务器，当前设备注册了设备标示
    // Required
    [APService registerDeviceToken:deviceToken];
    
    //这里收到了服务器的设备标识
    //极光可以给自己的设备设一个昵称，别名，以便单独发送数据给这部手机
    [APService setAlias:@"csl20151027" callbackSelector:nil object:nil];
    
    
    //这个别名，根据极光官方的说法，是不能重复的。因此，理应是，程序启动时，服务器发送给设备。
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}

//接收远程通通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //iOS7以后收到推送通知响应的方法
    
    
    NSLog(@"%@", userInfo);
    //收到推送时，如果程序是打开的，直接调用这个方法，如果程序是关闭的，系统会弹出推送托盘，点击托盘，会进入当前程序，调用这个方法。
    
    
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"XXX"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field =[%@]",content,(long)badge,sound,customizeField1);

    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

//创建标签栏
-(void) createAppFrame{
    //创建标签栏
    _tabBarController = [[CSLTabBarController alloc] init];
    //增加工具标签
    [_tabBarController addItem:NSLocalizedString(@"tabbar_tool",nil) normalImage:[UIImage imageNamed:@"tool.png"] highLightImage:[UIImage imageNamed:@"tool.png"] controller:@"CSLToolViewController"];
    
    //增加健康标签
    [_tabBarController addItem:NSLocalizedString(@"tabbar_health",nil) normalImage:[UIImage imageNamed:@"tabBar_heal.png"] highLightImage:[UIImage imageNamed:@"tabBar_heal.png"] controller:@"CSLHealthMainController"];
    
    //增加聊天室标签
    //[_tabBarController addItem:NSLocalizedString(@"tabbar_chatroom",nil) normalImage:[UIImage imageNamed:@"tabBar_chat.png"] highLightImage:[UIImage imageNamed:@"tabBar_chat.png"] controller:@"CSLChatroomViewController"];
    
    //增加我的标签
    [_tabBarController addItem:NSLocalizedString(@"tabbar_setting",nil) normalImage:[UIImage imageNamed:@"tabbar_setting.png"] highLightImage:[UIImage imageNamed:@"tabbar_setting.png"] controller:@"CSLSettingController"];
    
    //设置标签栏的viewControllers数组
    _tabBarController.viewControllers = _tabBarController.controllers;
    
    //设置window的rootviewcontroller
    self.window.rootViewController = _tabBarController;
}

//各种初始化
-(void) initApp:(NSDictionary *)launchOptions{
    //聚合初始化
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:JHAPPID];
    
    //极光推送
    [self jpush:launchOptions];
    
    //友盟分享的初始化
    [UMSocialData setAppKey:UMengAppKey];
    
    //环信初始化
//    [[EaseMob sharedInstance] registerSDKWithAppKey:@"1000phonemobile#chatdemo" apnsCertName:@"MyPushDemo20151125"];
}

//极光推送
-(void) jpush:(NSDictionary *)launchOptions{
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
}
@end
