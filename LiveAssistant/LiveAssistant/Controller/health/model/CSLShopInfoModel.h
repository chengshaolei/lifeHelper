//
//  CSLShopInfoModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/14.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@interface CSLShopInfoModel : JSONModel
@property(nonatomic,copy) NSString * address;
@property(nonatomic,assign) double createdate;
@property(nonatomic,copy) NSString * business;
@property(nonatomic,copy) NSString * charge;
@property(nonatomic,copy) NSString * img;
@property(nonatomic,copy) NSString * leader;
@property(nonatomic,copy) NSString *  legal;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * number;
@property(nonatomic,copy) NSString * tel;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * url;
@property(nonatomic,copy) NSString *  waddress;
@property(nonatomic,copy) NSString * x;
@property(nonatomic,copy) NSString * y;
@property(nonatomic,copy) NSString * zipcode;
@property(nonatomic,assign) NSUInteger  supervise;
@property(nonatomic,assign) NSUInteger status;
@property(nonatomic,assign) NSUInteger rcount;
@property(nonatomic,assign) NSUInteger fcount;
@property(nonatomic,assign) NSUInteger count;
@property(nonatomic,assign) NSUInteger area;
@end
