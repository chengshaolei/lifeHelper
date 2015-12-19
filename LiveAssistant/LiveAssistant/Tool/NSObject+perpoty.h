//
//  NSObject+perpoty.h
//  LiveAssistant
//
//  Created by csl on 15/12/18.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (perpoty)
-(NSArray*) getNullallProperties;//包括空值属性
- (NSArray *)getAllProperties;
- (NSDictionary *)properties_aps;
-(void)printMothList;
@end
