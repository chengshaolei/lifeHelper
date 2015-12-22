//
//  CSLTranlationModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

//枚举从1开始
typedef enum{
    ThemeClearStyle=1,
    ThemeBlackRoundStyle=2,
    ThemeBlueStyle=3,
    ThemeGrayStyle=4,
    ThemeOrangeStyle=5,
    ThemeBlackEdgeStyle=6
} ThemeStyle;

#define kMaxCityCount 5
@class CSLWeatherModel;
@interface CSLSetingDal : NSObject

+(CSLSetingDal *)sharedInstance;

-(ThemeStyle)getCurrentTheme;                           //获取当前的主题设置
-(void)updateCurrentTheme:(ThemeStyle)themeStyle;       //重新设置当前的主题

-(BOOL)isAutoLocation;                                  //是否启动自动适应地区
-(void)updateAutoLocation:(BOOL)flag;                   //修改是否自动适应地区功能

-(NSMutableArray *)getSaveCitylist;                     //获取本地存储的城市，如果没有则默认北京101010100，最多5
-(void)updateSavedCitylist:(NSMutableArray *)newCitylist;                             //排序后重新更新本地的顺序
-(void)insertNewCity:(NSString *)cityName;                  //新增城市,0-失败,1-成功
-(void)deleteCityByCity:(NSString *)cityName;            //通过cityName删除本地支持的城市天气

@end
