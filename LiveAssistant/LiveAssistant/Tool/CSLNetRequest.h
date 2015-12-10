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
typedef void (^FailureCallBack)(NSError* error);

@interface CSLNetRequest : NSObject

+(void) requestGet:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure;

//检测网络状态
//参数：netStatus block返回网络状态
//返回值：无
+(void) reachability:(void(^)(AFNetworkReachabilityStatus status))netStatus;
@end
