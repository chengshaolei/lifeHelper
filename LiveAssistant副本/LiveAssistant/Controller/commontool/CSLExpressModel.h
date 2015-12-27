//
//  CSLExpressModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/23.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@class CSLExpressStep;
@interface CSLExpressModel : JSONModel

@property (nonatomic, copy) NSString *mailNo;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *expSpellName;

@property (nonatomic, copy) NSString *errCode;

@property (nonatomic, copy) NSString *expTextName;

@property (nonatomic, strong) NSArray<CSLExpressStep *> *data;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *update;

@property (nonatomic, copy) NSString *cache;

@property (nonatomic, copy) NSString *tel;

@property (nonatomic, copy) NSString *ord;

@end
@interface CSLExpressStep : NSObject

@property (nonatomic, copy) NSString *context;

@property (nonatomic, copy) NSString *time;
@property(nonatomic,assign) float rowHeight;//文本高度
@end

