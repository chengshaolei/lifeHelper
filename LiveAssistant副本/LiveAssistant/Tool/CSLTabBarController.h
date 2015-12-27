//
//  CSLTabBarController.h
//  HomeTool
//
//  Created by csl on 15/12/7.
//  Copyright © 2015年 csl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLTabBarController : UITabBarController
@property(nonatomic,strong) NSMutableArray * controllers
;

//@tip  创建tabbaritem
//@para title tabbaritem标题
//      normal 正常情况下tabbaritem图片
//      selectedImage 选中情况下tabbaritem图片
//      controllerName tabbaritem所对应的的控制器
//@result  无
-(void) addItem:(NSString*)title normalImage:(UIImage*)normal highLightImage:(UIImage*)selectedImage controller:(NSString*)controllerName ;
@end
