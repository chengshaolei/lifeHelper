//
//  HQGetPlace.m
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 XJQ. All rights reserved.
//

#import "CSLGetPlace.h"
#import "CLLocation+Sino.h"
#import <CoreLocation/CoreLocation.h>
@implementation CSLGetPlace
{
    CLLocationManager * _location;
}
+ (instancetype)shareInstance {
    static CSLGetPlace * instance = nil;
    if(!instance) {
        instance = [[CSLGetPlace alloc] init];
    }
    return instance;
}

- (void)getPlace:(completeBlock)complete {
    if([CLLocationManager locationServicesEnabled]) {
        _location = [[CLLocationManager alloc] init];
        [_location requestWhenInUseAuthorization];
        _location.delegate = self;
        _location.desiredAccuracy = kCLLocationAccuracyBest;
        _location.distanceFilter = 5.0;
        [_location startUpdatingLocation];
        _success = complete;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * lastLocation = locations.lastObject;
    self.placeLocation = lastLocation;

    CLLocation * location = [[CLLocation alloc] initWithLatitude:fabs(lastLocation.coordinate.latitude) longitude:fabs(lastLocation.coordinate.longitude)];
    
    //地球坐标转火星坐标
    location = [location locationMarsFromEarth];
    
    //反向地理编码
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks firstObject];
        NSString * cityName = mark.locality;//获得城市名
        if(!cityName) {
            cityName = mark.administrativeArea;
        }
        if(self.success) {
            
            if ([cityName hasSuffix:@"市"]) {
                cityName = [cityName substringToIndex:cityName.length-1];
            }
            self.placeName = cityName;
            self.success(cityName);
            [_location stopUpdatingLocation];//关闭监视
        }
    }];

}

@end
