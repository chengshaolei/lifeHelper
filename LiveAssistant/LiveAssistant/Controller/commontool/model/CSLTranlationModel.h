//
//  CSLTranlationModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@class Basic,Web;

@interface CSLTranlationModel : JSONModel

@property (nonatomic, strong) Basic *basic;

@property (nonatomic, copy) NSString *query;

@property (nonatomic, strong) NSArray<NSString *> *translation;

@property (nonatomic, strong) NSArray<Web *> *web;

@end
@interface Basic : JSONModel

@property (nonatomic, copy) NSString *phonetic;

@property (nonatomic, copy) NSString *uk_phonetic;

@property (nonatomic, copy) NSString *us_phonetic;

@property (nonatomic, strong) NSArray<NSString *> *explains;

@end

@interface Web : JSONModel

@property (nonatomic, strong) NSArray<NSString *> *value;

@property (nonatomic, copy) NSString *key;

@end



