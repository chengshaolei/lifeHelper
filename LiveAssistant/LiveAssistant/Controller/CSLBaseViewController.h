//
//  CSLBaseViewController.h
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Auxiliary.h"
#import "CSLConstant.h"
#import "CSLNetRequest.h"

//自定义请求类型
typedef enum{NormalRequest,JHRequest} RequestType;


@interface CSLBaseViewController : UIViewController
@property(nonatomic,strong)  NSMutableArray * dataSource;//数据源
@property(nonatomic,assign) BOOL isLoadIndicator;//是否显示加载标志

//统一数据请求
//功能：完成数据请求，返回数据
//参数：type 请求的类型，可以普通请求（“0”）或聚合数据（“1”）
//     method :get、post
//     urlString:请求地址
//     dict:请求参数列表
-(void) requestType:(RequestType)type method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict;

//一般数据请求，子类实现
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict;

//百度apistore的header请求
-(void)request: (NSString*)urlStr;


//聚合数据请求
-(void) JHRequestWithAPPid:(NSString*)appid method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict;

-(void) showIndicatorInView:(UIView*)parentView isDisplay:(BOOL)show;//是否显示指示器

-(void) parserData:(id)data;//数据解析
@end
