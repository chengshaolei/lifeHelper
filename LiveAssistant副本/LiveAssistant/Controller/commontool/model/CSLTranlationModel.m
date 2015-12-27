//
//  CSLTranlationModel.m
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLTranlationModel.h"

@implementation CSLTranlationModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"web" : [Web class]};
}
@end


//uk_phonetic;

//@property (nonatomic, copy) NSString *us_phonetic;
@implementation Basic
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"us-phonetic": @"us_phonetic",
                                                       @"uk-phonetic": @"uk_phonetic"
                                                       }];
}
@end


@implementation Web

@end


