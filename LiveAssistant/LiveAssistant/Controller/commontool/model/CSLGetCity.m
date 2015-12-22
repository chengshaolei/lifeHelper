//
//  ZXGetCity.m
//  FintheWay
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 ZhangX. All rights reserved.
//

#import "CSLGetCity.h"

@implementation CSLGetCity

//得到全国城市名称
+ (NSArray *)getCityName{
    __autoreleasing NSMutableArray *cityArray = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ZXCity.plist" ofType:nil];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        for (NSDictionary *xCityName in dic[key]) {
            [cityArray addObject:xCityName[@"city_name"]];
        }
    }

    return cityArray;
    
}

@end
