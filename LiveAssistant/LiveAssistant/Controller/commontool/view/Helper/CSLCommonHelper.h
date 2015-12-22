//
//  HQCommonHelper.h
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface CSLCommonHelper : NSObject

+(CSLCommonHelper *)sharedInstance;

-(MBProgressHUD *) showHud:(id<MBProgressHUDDelegate>) delegate title:(NSString *) title  selector:(SEL) selector arg:(id) arg  targetView:(UIView *)targetView;

//传入路径和列表进行归档和反归档
-(void)archiverModel:(id)model filePath:(NSString *)filePath;
-(id)unArchiverModel:(NSString *)filePath;

@end
