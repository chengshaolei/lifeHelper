//
//  CSLNetRequest.h
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^CompleteCallBack)(id data);//请求完成时的回调
typedef void (^FailureCallBack)(NSError* error);//请求出错的回调

@interface CSLNetRequest : NSObject
//功能：get方式请求数据
//参数：urlString 网址
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+(void) get:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;

//功能：post方式请求数据
//参数：urlString 网址
//     paras 一个字典，请求参数
//     complete 请求完成时的回调
//     failure  请求出错的回调
//返回值：无
+(void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;

//功能：检测网络状态
//参数：urlString 网址
//返回值：网络联通返回YES，否则返回NO
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) urlString;

//聚合数据网络请求
//功能：通过聚合接口请求数据
//参数：method 请求方式：get/post
//    urlString 网址
//    dict 参数字典
//    done 请求成功回调；fail 请求失败的回调
//返回值：无
+(void) JHRequestAPPId:(NSString*)aid Method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict success:(void(^)(id reponeseData))done failure:(void(^)(NSError*))fail;
@end
