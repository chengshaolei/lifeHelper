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

+(instancetype) shareInstance;//单例

//验证
-(ErrorType) checkName:(NSString*)name password:(NSString*)password;

//在数据库里注册用户
-(ErrorType) registerUser:(NSString*)name password:(NSString*)password;
@end
