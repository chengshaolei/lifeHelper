//
//  CSLLoginViewController.h
//  登陆验证
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLLoginViewController : UIViewController
//登录成功的回调
@property(nonatomic,copy) void(^loginCallBack)(BOOL isLogin);
@end
