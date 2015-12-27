//
//  CSLRepeatSelectView.h
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义重复模式
typedef enum {OnlyOne=0,WorkDay,EveryDay} RepeatMode;

typedef void(^SeclectCallBack)(RepeatMode);
@interface CSLRepeatSelectView : UIView
@property(nonatomic,copy) SeclectCallBack choose;
@property(nonatomic,assign) RepeatMode mode;//重复模式

-(void) showinView:(UIView*)parentView complete:(SeclectCallBack)complete;//显示视图
@end
