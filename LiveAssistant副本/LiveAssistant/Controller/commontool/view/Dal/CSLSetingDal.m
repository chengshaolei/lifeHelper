//
//  CSLTranlationModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLSetingDal.h"
#import "CSLWeatherModel.h"
#import "CSLCommonHelper.h"

#define kCityArchiverPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"savedcity"]

static CSLSetingDal *instance;

@implementation CSLSetingDal

+(CSLSetingDal *)sharedInstance {
    if(instance==nil) {
        instance=[[CSLSetingDal alloc] init];
    }
    return instance;
}

-(ThemeStyle)getCurrentTheme {
    NSNumber *number=[[NSUserDefaults standardUserDefaults] objectForKey:@"ThemeSetting"];
    int theme=[number intValue];
    if(theme<1||theme>6) {
        [self updateCurrentTheme:ThemeClearStyle];
        return ThemeClearStyle;
    }
    return (ThemeStyle)theme;
}

-(void)updateCurrentTheme:(ThemeStyle)themeStyle {
    if((int)themeStyle<1||(int)themeStyle>6) {
        themeStyle=ThemeClearStyle;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:themeStyle] forKey:@"ThemeSetting"];
}

-(BOOL)isAutoLocation {
    return 1;
}

-(void)updateAutoLocation:(BOOL)flag {
    NSNumber *number=[NSNumber numberWithBool:flag];
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"AutoLocation"];
}

-(void)updateSavedCitylist:(NSMutableArray *)newCitylist {
    [[CSLCommonHelper sharedInstance] archiverModel:newCitylist filePath:kCityArchiverPath];
}

-(NSMutableArray *)getSaveCitylist {
    NSMutableArray *citylist = [[CSLCommonHelper sharedInstance] unArchiverModel:kCityArchiverPath];
    if(citylist.count <= 0) {
        citylist = [[NSMutableArray alloc] init];
        NSString * city = @"北京";
        [citylist addObject:city];
    }
    return citylist;
}

-(void)insertNewCity:(NSString *)cityName {
    if(!cityName) {
        return;
    }
    NSMutableArray *citylist=[[CSLCommonHelper sharedInstance] unArchiverModel:kCityArchiverPath];
    if(citylist==nil) {
        citylist=[[NSMutableArray alloc] init];
    }
    for (NSString * name in citylist) {
        if ([name isEqualToString:cityName]) {
            return;
        }
    }
    [citylist addObject:cityName];
    [[CSLCommonHelper sharedInstance] archiverModel:citylist filePath:kCityArchiverPath];
}

-(void)deleteCityByCity:(NSString *)cityName {
    NSString *cityname=[NSString stringWithString:cityName];
    if(cityname==nil) {
        return;
    }
    NSMutableArray *citylist=[[CSLCommonHelper sharedInstance] unArchiverModel:kCityArchiverPath];
    for(NSString * city in citylist) {
        if([city isEqualToString:cityname]) {
            [citylist removeObject:city];
            break;
        }
    }
    [[CSLCommonHelper sharedInstance] archiverModel:citylist filePath:kCityArchiverPath];
}
@end
