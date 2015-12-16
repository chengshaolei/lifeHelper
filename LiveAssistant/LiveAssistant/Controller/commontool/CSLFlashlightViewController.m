//
//  CSLFlashlightViewController.m
//  LiveAssistant
//  手电筒
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLFlashlightViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Auxiliary.h"

@interface CSLFlashlightViewController ()

@end

@implementation CSLFlashlightViewController
@synthesize isLightOn = _isLightOn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"手电筒";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(80, 150, 100, 80)];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //AVCaptureDevice代表抽象的硬件设备
    // 找到一个合适的AVCaptureDevice
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {//判断是否有闪光灯
        __weak CSLFlashlightViewController* weakSelf = self;
        [Auxiliary alertWithTitle:NSLocalizedString(@"alertTitle", nil) message:NSLocalizedString(@"flashlightNotSupport", nil) button:1 done:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    isLightOn = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}



-(void)btnClicked
{
    isLightOn = 1-isLightOn;
    if (isLightOn) {
        [self turnOnLed:YES];
    }else{
        [self turnOffLed:YES];
    }
}

//打开手电筒
-(void) turnOnLed:(bool)update
{
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device unlockForConfiguration];
}

//关闭手电筒
-(void) turnOffLed:(bool)update
{
    [device lockForConfiguration:nil];
    [device setTorchMode: AVCaptureTorchModeOff];
    [device unlockForConfiguration];
}
@end
