//
//  HQSingleWeatherView.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSLSetingDal.h"

@class HQWeatherModel;

@interface CSLSingleWeatherView : UIView <CLLocationManagerDelegate,UICollectionViewDataSource> {
    ThemeStyle _currentStle;
}
@property (nonatomic,copy) UIImageView * bgImageView;
@property (nonatomic,strong) UIImageView *clockbgBgImgView;
@property (nonatomic,strong) UIImageView *effectBgImgView;
@property (nonatomic,strong) UIImageView *hourLeftImgView;
@property (nonatomic,strong) UIImageView *hourRightImgView;
@property (nonatomic,strong) UIImageView *minuteLeftImgView;
@property (nonatomic,strong) UIImageView *minuteRightImgView;
@property (nonatomic,strong) UIImageView *todayImgView;
@property (nonatomic,strong) UILabel *lblDate;
@property (nonatomic,strong) UILabel *lblPlace;
@property (nonatomic,strong) UILabel *lblTemp;
@property (nonatomic,strong) UILabel *lblWeather;
@property (nonatomic,strong) UILabel *lblWind;
@property (nonatomic,strong) UILabel *lblWindLevel;
@property (nonatomic,strong) UICollectionView * futureWeather;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,strong) CSLWeatherModel * currentCity;
@property (nonatomic,copy) NSString *currentCityName;
- (id)initWithFrame:(CGRect)frame withCity:(CSLWeatherModel *)city;
- (void)updateMainInThread:(CSLWeatherModel *)city;
@end
