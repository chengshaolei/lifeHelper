//
//  CSLDrugstoreModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/14.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"
@interface CSLPosition : JSONModel
@property(nonatomic,copy)   NSString * city;
@property(nonatomic,assign) NSUInteger id;
@property(nonatomic,assign) NSUInteger level;
@property(nonatomic,copy)   NSString * province;
@property(nonatomic,copy)   NSString * region;
@property(nonatomic,assign) NSUInteger seq;
@property(nonatomic,assign) double x;
@property(nonatomic,assign) double y;
@end

@interface CSLPositionModel : JSONModel
@property(nonatomic,copy)   NSString * city;
@property(nonatomic,assign) NSUInteger id;
@property(nonatomic,assign) NSUInteger level;
@property(nonatomic,copy)   NSString * province;
@property(nonatomic,strong) NSArray<CSLPosition *> * provinces;
@property(nonatomic,copy)   NSString * region;
@property(nonatomic,assign) NSUInteger seq;
@property(nonatomic,assign) double x;
@property(nonatomic,assign) double y;
@end
