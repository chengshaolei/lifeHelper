//
//  CSLDrugListModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/17.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@interface CSLDrugListModel : JSONModel

@property (nonatomic, copy) NSString *style;

@property (nonatomic, copy) NSString *use;

@property (nonatomic, copy) NSString *function;

@property (nonatomic, copy) NSString *factory;

@property (nonatomic, copy) NSString *theory;

@property (nonatomic, copy) NSString *cName;

@property (nonatomic, copy) NSString *ingredients;

@property (nonatomic, copy) NSString *forbidden;

@property (nonatomic, copy) NSString *bad;

@property (nonatomic, copy) NSString *coverUrl;

@property (nonatomic, copy) NSString *storage;

@property (nonatomic, copy) NSString *attention;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *pizhun;

@end
