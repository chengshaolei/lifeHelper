//
//  HQWeatherModel.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "JSONModel.h"
#import "CSLDayWeatherModel.h"

typedef enum{
    WeatherClearType=0,                         //晴天
    WeatherPartlySunnyType=1,                   //多云
    WeatherOverCastType=2,                      //阴
    WeatherFogType=3,                           //雾
    WeatherRainAndSnowType=4,                   //雨夹雪
    WeatherWindType=5,                          //风
    WeatherScatterShowerType=6,                 //零星阵雨
    WeatherShowerType=7,                        //阵雨
    WeatherThunderStormType=8,                  //雷阵雨
    WeatherScatterThunderStormType=9,           //零星雷阵雨
    WeatherLightRainType=10,                    //小雨
    WeatherRainType=11,                         //中雨或者大雨
    WeatherStormType=12,                        //暴雨或者特大暴雨
    WeatherScatterSnowType=13,                  //阵雪
    WeatherFlurryType=14,                       //小雪
    WeatherIceSnowType=15,                      //中雪
    WeatherSnowType=16,                         //大雪
    WeatherIceType=17,                          //暴雪
    WeatherHailType=18,                         //冰雹类的天气
} WeatherType;

@interface CSLWeatherModel : JSONModel
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * cityid;
@property (nonatomic,copy) CSLDayWeatherModel * today;
@property (nonatomic,strong) NSArray<CSLDayWeatherModel *> * forecast;
@property (nonatomic,strong) NSArray<CSLDayWeatherModel *> * history;
@property (nonatomic,copy) NSString *effectImg;
@property (nonatomic,copy) NSString *weatherImage;
@property (nonatomic) WeatherType weatherType;
@property (nonatomic,copy) NSString *vedioName;
@end
