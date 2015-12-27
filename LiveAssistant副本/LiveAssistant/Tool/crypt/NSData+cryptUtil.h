//
//  NSData+cryptUtil.h
//  LiveAssistant
//
//  Created by csl on 15/12/25.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (cryptUtil)
//AES加密算法
//参数：key 加密的密码
//返回值：加密后的二级制数据
- (NSData*)AES256EncryptWithKey:(NSString*)key;

//AES解密算法
//参数：key 解密的密码（和加密密码相同)
//返回值：解密后的二级制数据
- (NSData*)AES256DecryptWithKey:(NSString*)key;
@end
