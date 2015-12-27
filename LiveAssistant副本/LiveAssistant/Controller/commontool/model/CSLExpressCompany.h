//
//  CSLExpressCompany.h
//  LiveAssistant
//
//  Created by csl on 15/12/23.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@interface CSLExpressCompany : JSONModel
@property(nonatomic,copy) NSString *shortName;//简称
@property(nonatomic,copy) NSString * name;//公司名称
@end
