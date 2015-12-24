//
//  auxiliary.m
//  xmppClientDemo
//
//  Created by csl on 15/11/28.
//  Copyright © 2015年 csl. All rights reserved.
//

#import "Auxiliary.h"
#import "AppDelegate.h"

@implementation Auxiliary
+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSUInteger)buttons done:(void (^)())act{
    
    //创建一个新窗口，用于显示警告框
    UIApplication * application = [UIApplication sharedApplication];
    UIWindow * oldWindow = application.keyWindow;
    UIWindow *window = [[UIWindow alloc] initWithFrame:oldWindow.bounds];
    window.backgroundColor = [UIColor clearColor];//窗口的背景颜色
    
    //实例化一个控制器，用于弹出警告框
    UIViewController * controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor clearColor];
    window.rootViewController = controller;

    
    //实例化警告框
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //确定按钮
    UIAlertAction * okButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(act){
           act();
        }
        
        [oldWindow makeKeyAndVisible];
    }];
    [alertController addAction:okButton];
    
    //如果是两个按钮，则增加一个取消按钮
    if (buttons==2) {
        UIAlertAction * cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelButton];
    }
    
    //显示新增窗口
    [window makeKeyAndVisible];
    
    //弹出警告框
    [controller presentViewController:alertController animated:YES completion:nil];
    
}

+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSUInteger)buttons inController:(UIViewController*)controller done:(void (^)())act{
    
    
    //实例化警告框
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //确定按钮
    UIAlertAction * okButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(act){
            act();
        }
       
    }];
    [alertController addAction:okButton];
    
    //如果是两个按钮，则增加一个取消按钮
    if (buttons==2) {
        UIAlertAction * cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelButton];
    }
    
    //弹出警告框
    [controller presentViewController:alertController animated:YES completion:nil];
}


+(void) alertWithTitle:(NSString*)title message:(NSString*)message button:(NSArray*)buttons done:(void (^)())agree cancel:(void (^)())disagree{
    //创建一个新窗口，用于显示警告框
    UIApplication * application = [UIApplication sharedApplication];
    UIWindow * oldWindow = application.keyWindow;
    UIWindow *window = [[UIWindow alloc] initWithFrame:oldWindow.bounds];
    window.backgroundColor = [UIColor clearColor];//窗口的背景颜色
    
    //实例化一个控制器，用于弹出警告框
    UIViewController * controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor clearColor];
    window.rootViewController = controller;
    
    //实例化警告框
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //第一个按钮
    UIAlertAction * btn1 = [UIAlertAction actionWithTitle:buttons[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(agree){
            agree();
            [oldWindow makeKeyAndVisible];
        }
        }];
    [alertController addAction:btn1];
    
    //第一个按钮
    UIAlertAction * btn2 = [UIAlertAction actionWithTitle:buttons[1] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(disagree){
            disagree();
            [oldWindow makeKeyAndVisible];
        }
    }];
    [alertController addAction:btn2];
    
    //显示新增窗口
    [window makeKeyAndVisible];
    
    //弹出警告框
    [controller presentViewController:alertController animated:YES completion:nil];

}

+(CATransition*) transitWithProperties:(NSDictionary*)properties{
    //定义转场动画
    __autoreleasing CATransition * transition = [CATransition animation];
    
    //动画类型
    NSString * type = properties[@"type"];
    transition.type = type? type : @"fade";
    
    //动画方向
    NSString * subType = properties[@"subType"];
    transition.subtype = subType?subType : kCATransitionFromRight;
    NSString * duration = properties[@"duration"];
    transition.duration = duration?[duration floatValue]:1.0;
    
    //时间曲线
    NSString * timimgFountion = properties[@"timimgFountion"];
    CAMediaTimingFunction * tf = nil;
    if (timimgFountion) {
        tf = [CAMediaTimingFunction functionWithName:timimgFountion];
    }
    
    transition.timingFunction = tf?tf:UIViewAnimationCurveEaseInOut;
    
    //填充模式
    NSString * fillMode = properties[@"fillMode"];
    transition.fillMode = fillMode?fillMode : @"removed";
    
    return transition;
}

+(CGFloat) dynamicHeightWithString:(NSString*)string width:(CGFloat)width attribute:(NSDictionary*)attrs{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrs context:nil];
    return rect.size.height;
}

+(void) layerCornerRadius:(CALayer*)dest radius:(float)radius width:(float)width color:(UIColor*)color{
    dest.cornerRadius = radius;
    dest.borderWidth = width;
    dest.borderColor = color.CGColor;
    dest.masksToBounds = YES;
}

+(void)checkVersion:(NSString*)appid
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSString *URL =[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    __autoreleasing NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:&error] ;
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        if (![lastVersion isEqualToString:currentVersion]) {
            [Auxiliary alertWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" button:@[@"更新",@"取消"] done:^{
                NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
                [[UIApplication sharedApplication]openURL:url];
            } cancel:^{
                
            }];
        }
        else
        {
            [Auxiliary alertWithTitle:@"更新" message:@"此版本为最新版本" button:1 done:nil];
        }
    }
    else{
        [Auxiliary alertWithTitle:@"更新" message:@"应用还未上线，无法查询！" button:1 done:nil];
    }
}
@end
