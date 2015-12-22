//
//  HQWeatherDAL.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HQWeatherModel;

@interface CSLWeatherDAL : NSObject

+(CSLWeatherDAL *)sharedInstaced;
-(NSString *)getImageNameFromString:(NSString *)weather;
-(NSString *)getVideoNameGFromString:(NSString *)weather;
@end
