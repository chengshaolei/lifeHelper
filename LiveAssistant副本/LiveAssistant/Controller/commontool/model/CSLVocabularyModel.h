//
//  VSLVocabularyModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/19.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"


@interface CSLVocabularyModel : JSONModel

@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *bushou;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *py;
@property (nonatomic, copy) NSString *bihua;
@property (nonatomic, copy) NSString *zi;
@property (nonatomic, copy) NSString *wubi;
@property (nonatomic, copy) NSString *sequence;//笔画顺序

@property (nonatomic, strong) NSArray<NSString *> *jijie;
@property (nonatomic, strong) NSArray<NSString *> *xiangjie;

@end

