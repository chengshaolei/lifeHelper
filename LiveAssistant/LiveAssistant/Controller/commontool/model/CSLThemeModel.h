//
//  HQThemeModel.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSLSetingDal.h"

@interface CSLThemeModel : NSObject
@property (nonatomic,copy) NSString *themeName;
@property (nonatomic,strong) UIImage *themeImage;
@property (nonatomic) ThemeStyle themeStyle;
@end
