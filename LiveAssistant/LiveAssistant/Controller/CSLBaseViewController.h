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

//数据请求，子类实现
-(void) requestData:(NSString*)urlString para:(NSDictionary*)dict;
@end
