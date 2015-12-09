//
//  auxiliary.h
//  xmppClientDemo
//
//  Created by csl on 15/11/28.
//  Copyright © 2015年 csl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Auxiliary : NSObject
////警告框
+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSUInteger)buttons done:(void (^)())act;

//+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSUInteger)buttons inController:(UIViewController*)controller done:(void (^)())act;

//两个按钮
+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSArray*)buttons done:(void (^)())agree cancel:(void (^)())disagree;

//定义转场动画
//参数：properties字典，每一个键值对描述一个动画属性，常用的有：
//     动画类型： pageCurl            向上翻一页
//              pageUnCurl          向下翻一页
//              rippleEffect        滴水效果
//              suckEffect          收缩效果，如一块布被抽走
//              cube                立方体效果
//              oglFlip             上下翻转效果
//     动画方向： kCATransitionFromRight kCATransitionFromLeft kCATransitionFromTop kCATransitionFromBottom;
//     动画时间曲线：linear(线性) easeIn() easeOut() easeInEaseOut()
//      动画时间：默认动画时间是1秒
//返回值：返回生成的过渡动画对象
//调用示例：CATransition * transition = [Auxiliary transitWithProperties:@{@"type":@"cube",@"subType":@"fromRight",@"duration":@"1"}];
//   [self.navigationController.view.layer    addAnimation:transition forKey:nil]
+(CATransition*) transitWithProperties:(NSDictionary*)properties;
@end
