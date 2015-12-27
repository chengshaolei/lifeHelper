//
//  CSLUser.h
//  登陆验证
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>
//错误类型
typedef enum {ERROR,SUCCESS}ErrorType ;

@interface CSLUser : NSObject
@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,assign) BOOL isLogin;//是否登录

//功能：检测用户是否登录
//参数：无
//返回值：登录返回YES，否则返回NO
-(BOOL) isLoginedUser;

+(instancetype) shareInstance;//单例

//功能：验证用户名、密码是否正确
//参数：name 用户名
//     password 密码
//返回值：成功返回SUCCESS,否则返回ERROR
-(ErrorType) checkName:(NSString*)name password:(NSString*)password;

//功能：是否重名
//参数：name 用户名
//返回值：重名返回YES，否返回NO
-(BOOL) isDuplicateName:(NSString*)name;


//功能：在数据库里注册用户
//参数：name 用户名
//     password 密码
//返回值：成功返回SUCCESS,否则返回ERROR
-(ErrorType) registerUser:(NSString*)name password:(NSString*)password;
@end
