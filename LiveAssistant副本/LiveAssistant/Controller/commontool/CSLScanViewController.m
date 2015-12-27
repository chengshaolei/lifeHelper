//
//  CSLToolViewController.h
//  HomeTool
//
//  Created by csl on 15/12/9.
//  Copyright © 2015年 csl. All rights reserved.
//
#import "CSLScanViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"

//静态指针
static QRCodeReaderViewController *vc = nil;

@interface CSLScanViewController ()

-(void) createScanViewController;//创建扫描控制器
- (void)scanAction;//扫描
@end

@implementation CSLScanViewController
{
    BOOL _isScanFinished;//判断扫描是否结束(YES)，默认没有
}

-(void) viewDidLoad{
    [super viewDidLoad];
    [self createScanViewController];
    self.navigationController.navigationBar.hidden= YES;
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!_isScanFinished) {//如果扫描没结束
        [self scanAction];//开始扫描
    }
    
}
-(void) createScanViewController{
    //判断设备是否支持二维码扫描
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        //使用线程安全的方式创建一个单例
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{//只执行一次
            //设置扫描类型为二维码
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            
            //创建扫描控制器
            vc  = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:NO showSwitchCameraButton:YES showTorchButton:YES];
         });
    }
    else {//不支持
        //弹框通知
        [Auxiliary alertWithTitle:NSLocalizedString(@"alertTitle", nil) message:NSLocalizedString(@"scanReaderNotSupport", nil) button:1 done:nil];
    }
    
    //把扫描控制器的view加到当前的view上，不采用模态视图控制器方式操作
    [self.view addSubview:vc.view];
}
- (void)scanAction
{
    if (!_isScanFinished) {
        [vc startScanning];//开始扫描
    }
    
    //避免循环引用
    __weak CSLScanViewController*weakSelf = self;
    
    //扫描完成后回自动回调block
    //因为扫描过快，会发生多次扫描，会多次调用block
    [vc setCompletionWithBlock:^(NSString * _Nullable resultAsString) {
        [vc stopScanning];//停止扫描
        if (!_isScanFinished) {//使用_isScanFinished避免多次调用
            _isScanFinished = YES;//置标志为真
            [Auxiliary alertWithTitle:NSLocalizedString(@"alertTitle", nil) message:resultAsString button:1 done:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    }];
}

@end
