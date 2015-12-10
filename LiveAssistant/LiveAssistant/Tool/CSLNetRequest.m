//
//  CSLNetRequest.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLNetRequest.h"


@implementation CSLNetRequest
+(void) requestGet:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void) reachability:(void(^)(AFNetworkReachabilityStatus status))netStatus
{
    
    // 检测网络连接状态
    AFNetworkReachabilityManager * reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];//开启监测
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (netStatus) {
            netStatus(status);
        }
    }];
}
@end
