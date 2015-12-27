//
//  AppDelegate.h
//  LiveAssistant
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CSLTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) CSLTabBarController * tabBarController;

@end

