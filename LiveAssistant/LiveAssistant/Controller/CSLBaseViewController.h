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

@interface CSLBaseViewController : UIViewController
@property(nonatomic,strong)  NSMutableArray * dataSource;//数据源

//一般数据请求，子类实现
-(void) request:(NSString*)method url:(NSString*)urlString para:(NSDictionary*)dict;

//聚合数据请求
-(void) JHRequestWithAPPid:(NSString*)appid method:(NSString*)method url:(NSString*)urlString paras:(NSDictionary*)dict;


-(void) parserData:(id)data;//数据解析
@end
