//
//  CSLUser.h
//  登陆验证
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//


#import "CSLUser.h"
#import "CSLDataBase.h"
#import "FMDB.h"
#define kFileName @"user.plist";

@implementation CSLUser
+(instancetype) shareInstance{//单例
    static CSLUser * user = nil;//静态局部变量或静态全局变量
    if (user==nil) {//判断user是否为空
        user = [[CSLUser alloc] init];
    }
    return user;
}

//读取数据库
-(BOOL) readUser:(NSString*)name password:(NSString*)pwd{
    CSLDBManager * dbManager = [CSLDBManager defaultDBManager];
    NSArray * users = [dbManager  select:@"select * from user where username = ? and password = ?" where:@[name,pwd]];
    if (users && users.count>0) {
        NSDictionary * user = users[0];
        self.userName = user[@"username"];
        self.password = user[@"password"];
        return YES;
    }
    
    return NO;
}



//验证
-(ErrorType) checkName:(NSString*)name password:(NSString*)password{
    BOOL flag = NO;
    flag = [self readUser:name password:password];
    return flag?SUCCESS:ERROR;
}

-(BOOL) isDuplicateName:(NSString*)name{
    CSLDBManager * dbManager = [CSLDBManager defaultDBManager];;
    NSArray * result = [dbManager select:@"select username from user where username = ?" where:@[name]];
    if (result&&result.count>0) {
        return YES;
    }
    return NO;
}
-(BOOL) isInDataBase:(NSString*)name uid:(NSString*)uid{
    CSLDBManager * dbManager = [CSLDBManager defaultDBManager];;
    NSArray * result = [dbManager select:@"select username from user where username = ? and password = ?" where:@[name,uid]];
    if (result&&result.count>0) {
        return YES;
    }
    return NO;
}

-(ErrorType) registerUser:(NSString*)name password:(NSString*)password{
     CSLDBManager * dbManager = [CSLDBManager defaultDBManager];
    return [dbManager insertTable:@"user" record:@{@"username":name,@"password":password}];
}

-(BOOL) isLoginedUser{
    //如果用户名和密码不空和islogin为真，则为登录
    return self.userName.length>0 && self.password.length>0 &&self.isLogin;
}
@end
