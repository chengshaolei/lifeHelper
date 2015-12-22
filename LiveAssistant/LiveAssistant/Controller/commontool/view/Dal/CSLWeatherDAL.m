//
//  HQWeatherDAL.m
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "CSLWeatherDAL.h"
#import "CSLWeatherModel.h"

static CSLWeatherDAL *instance;

@implementation CSLWeatherDAL
+(CSLWeatherDAL *)sharedInstaced
{
    if(instance==nil)
    {
        instance=[[CSLWeatherDAL alloc] init];
    }
    return instance;
}


//判断是否是黑夜时间
-(BOOL)isNight {
    NSDate *startDate=[NSDate date];
    
    NSCalendar *chineseCalendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSDateComponents *dateComponents=[chineseCalendar components:unitFlags fromDate:startDate];
    if(([dateComponents hour]>=0&&[dateComponents hour]<=5)||([dateComponents hour]>=20&&[dateComponents hour]<=24)) {
        return YES;
    }
    return NO;
}

//根据获取天气的关键字返回相应的图片名称
-(NSString *)getImageNameFromString:(NSString *)weather {
    if(weather==nil) {
        NSLog(@"传入的天气名称为nil");
        return nil;
    }
    NSString *weatherString=[NSString stringWithString:weather];
    NSUInteger location = [weatherString rangeOfString:@"转"].location;
    if(location<100) {
        weatherString=[weatherString substringFromIndex:location+1];
    }
    if([weatherString isEqualToString:@"晴"])
    {
        return @"clear";
    }
    
    if([weatherString isEqualToString:@"多云"])
    {
        return @"cloudy";
    }
    
    if([weatherString isEqualToString:@"阴"])
    {
        return @"overcast";
    }
    
    if([weatherString isEqualToString:@"雾"] || [weatherString isEqualToString:@"霾"])
    {
        return @"fog";
    }
    
    //------------雨
    if([weatherString isEqualToString:@"阵雨"])
    {
        return @"showers";
    }
    
    if([weatherString isEqualToString:@"雷阵雨"])
    {
        return @"thunderstorm";
    }
    
    if([weatherString isEqualToString:@"雨夹雪"])
    {
        return @"rainandsnow";
    }
    
    if([weatherString isEqualToString:@"小雨"])
    {
        return @"lightrain";
    }
    
    if(([weatherString isEqualToString:@"中雨"])||([weatherString isEqualToString:@"大雨"]))
    {
        return @"rain";
    }
    
    if(([weatherString isEqualToString:@"暴雨"])||([weatherString isEqualToString:@"大暴雨"])||([weatherString isEqualToString:@"特大暴雨"]))
    {
        return @"storm";
    }
    
    //-------------雪
    if([weatherString isEqualToString:@"阵雪"])
    {
        return @"scatteredsnow";
    }
    
    if([weatherString isEqualToString:@"小雪"])
    {
        return @"flurries";
    }
    
    if([weatherString isEqualToString:@"中雪"])
    {
        return @"icesnow";
    }
    
    if([weatherString isEqualToString:@"大雪"])
    {
        return @"snow";
    }
    
    if([weatherString isEqualToString:@"暴雪"])
    {
        return @"icy";
    }
    return nil;
}

-(NSString *)getVideoNameGFromString:(NSString *)weather {
    if (weather != nil) {
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSString * weatherImgName = [self getImageNameFromString:weather];
        NSString * vedioPath = [[NSBundle mainBundle] pathForResource:weatherImgName ofType:@"mp4"];
        if ([fileManager fileExistsAtPath:vedioPath]) {
            return vedioPath;
        }
        else  {
            return @"clear.mp4";
        }
    }
    return nil;
}

@end
