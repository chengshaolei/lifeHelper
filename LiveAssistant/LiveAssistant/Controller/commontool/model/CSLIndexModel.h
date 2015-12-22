//
//  HQIndexModel.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/26.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "JSONModel.h"

@protocol HQIndexModel

@end

@interface CSLIndexModel : JSONModel
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * details;
@property (nonatomic,copy) NSString * index;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString<Optional> * otherName;
@end
