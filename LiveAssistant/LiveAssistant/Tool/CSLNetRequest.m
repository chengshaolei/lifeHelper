//
//  CSLNetRequest.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLNetRequest.h"
#import "CSLConstant.h"
#import "JHAPISDK.h"
#import "Auxiliary.h"

@implementation CSLNetRequest
+(void) get:(NSString*)urlString complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{

    
    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //请求
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (complete) {
            complete(responseObject);//调用block将请求数据返回
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);//将错误信息返回
        }
    }];
}

+(void) post:(NSString*)urlString para:(NSDictionary*)paras complete:(CompleteCallBack)complete fail:(FailureCallBack)failure{

    //得到AFHTTPRequestOperationManager请求的单例
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    
    //设置返回数据格式（二进制）
    requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //请求
    [requestManager POST:urlString parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject){
        if (complete) {
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * __nullable operation, NSError *error){
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
    
    //获得网络连接状态
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (netStatus) {
            netStatus(status);//调用block返回网络状态
        }
    }];
}

//测试网络连接
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                //联通状态
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
                //非联通状态
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}


+(void) JHRequestAPPId:(NSString*)aid Method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict success:(void(^)(id reponeseData))done failure:(void(^)(NSError*))fail{
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:urlString APIID:aid Parameters:dict Method:method Success:^(id responseObject) {
        if (done) {
            done(responseObject);
        }
    } Failure:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
@end
