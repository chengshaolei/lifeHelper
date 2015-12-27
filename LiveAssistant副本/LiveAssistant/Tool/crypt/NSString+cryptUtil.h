//
//  NSString+MD5.h
//  LiveAssistant
//
//  Created by csl on 15/12/25.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (cryptUtil)
//获得字符串的md5的32位签名
-(NSString*) md5;

//功能：AES加密算法
//参数：strSource 原文
//     key  加密秘钥
//返回值：加密后的二进制数据
+ (NSData*)AES256Encrypt:(NSString*)strSource withKey:(NSString*)key;

//功能：AES解密算法
//参数：dataSource 密文
//     key  解密秘钥
//返回值：加密后的原文
+ (NSString*)AES256Decrypt:(NSData*)dataSource withKey:(NSString*)key;

@end
