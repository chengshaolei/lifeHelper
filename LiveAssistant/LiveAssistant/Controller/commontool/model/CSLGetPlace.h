//
//  XPGetPlace.h
//  FintheWay
//
//  Created by qianfeng on 15/10/12.
//  Copyright (c) 2015年 XP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface CSLGetPlace : NSObject<CLLocationManagerDelegate>
typedef void(^completeBlock)(NSString *);
typedef void(^locationBlock)(CLLocation *);
@property (nonatomic, copy)completeBlock success;
@property (nonatomic, copy)locationBlock locationBloc;

@property (nonatomic, strong) CLLocation *placeLocation;
@property (nonatomic, copy)NSString * placeName;
+ (instancetype)shareInstance;
- (void)getPlace :(completeBlock)complete;
@end
