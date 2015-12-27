//
//  NSString+MD5.m
//  LiveAssistant
//
//  Created by csl on 15/12/25.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "NSString+cryptUtil.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+cryptUtil.h"

@implementation NSString (cryptUtil)

//MD5签名算法
-(NSString*) md5 {
    const char * cStrValue = [self UTF8String];
    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStrValue, (CC_LONG)strlen(cStrValue), theResult);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            theResult[0], theResult[1], theResult[2], theResult[3],
            theResult[4], theResult[5], theResult[6], theResult[7],
            theResult[8], theResult[9], theResult[10], theResult[11],
            theResult[12], theResult[13], theResult[14], theResult[15]];
}

//加密
+ (NSData*)AES256Encrypt:(NSString*)strSource withKey:(NSString*)key {
    NSData *dataSource = [strSource dataUsingEncoding:NSUTF8StringEncoding];
    return [dataSource AES256EncryptWithKey:[key md5]];
}

//解密
+ (NSString*)AES256Decrypt:(NSData*)dataSource withKey:(NSString*)key {
    NSData *decryptData = [dataSource AES256DecryptWithKey:[key md5]];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

@end

