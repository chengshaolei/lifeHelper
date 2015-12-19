//
//  CSLTermModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/19.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "JSONModel.h"

@interface CSLTermModel : JSONModel

@property (nonatomic, copy) NSString *bushou;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *chengyujs;

@property (nonatomic, copy) NSString *yufa;

@property (nonatomic, copy) NSString *ciyujs;

@property (nonatomic, copy) NSString *yinzhengjs;

@property (nonatomic, strong) NSArray<NSString *> *tongyi;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, strong) NSArray<NSString *> *fanyi;

@property (nonatomic, copy) NSString *example;

@property (nonatomic, copy) NSString *from_;

@end
