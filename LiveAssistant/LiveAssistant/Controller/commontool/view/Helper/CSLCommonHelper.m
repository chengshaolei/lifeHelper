//
//  HQCommonHelper.m
//  HanQiuWeather
//
//  Created by qianfeng on 15/10/27.
//  Copyright © 2015年 XuJianQiu. All rights reserved.
//

#import "CSLCommonHelper.h"
#import "CSLWeatherModel.h"

static CSLCommonHelper *instance;
@implementation CSLCommonHelper

+(CSLCommonHelper *)sharedInstance {
    if(instance==nil) {
        instance=[[CSLCommonHelper alloc] init];
    }
    return instance;
}

-(MBProgressHUD *) showHud:(id<MBProgressHUDDelegate>) delegate title:(NSString *) title  selector:(SEL) selector arg:(id) arg  targetView:(UIView *)targetView {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    [targetView addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.delegate = delegate;
    hud.labelText = title;
    [hud showWhileExecuting:selector
                   onTarget:delegate
                 withObject:arg
                   animated:YES];
    return hud;
}

-(void)archiverModel:(id)model filePath:(NSString *)filePath {
    NSMutableData *archiverData=[[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:archiverData];
    [archiver encodeObject:model forKey:@"Data"];
    [archiver finishEncoding];
    BOOL flag=[archiverData writeToFile:filePath atomically:NO];
    if(!flag) {
    }
}

-(id)unArchiverModel:(NSString *)filePath {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]) {
        return nil;
    }
    
    NSData *unArchiverData=[[NSData alloc] initWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:unArchiverData];
    id model=[unarchiver decodeObjectForKey:@"Data"];
    [unarchiver finishDecoding];
    return model;
}

@end
