//
//  HQDayWeatherModel.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "JSONModel.h"
#import "CSLIndexModel.h"
@protocol CSLDayWeatherModel

@end

@interface CSLDayWeatherModel : JSONModel
@property (nonatomic,copy) NSString * date;
@property (nonatomic,copy) NSString * week;
@property (nonatomic,copy) NSString<Optional> * curTemp;
@property (nonatomic,copy) NSArray<CSLIndexModel> * index;
@property (nonatomic,copy) NSString * fengxiang;
@property (nonatomic,copy) NSString * fengli;
@property (nonatomic,copy) NSString * hightemp;
@property (nonatomic,copy) NSString * lowtemp;
@property (nonatomic,copy) NSString * type;
@end
