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

static QRCodeReaderViewController *vc = nil;
@interface CSLScanViewController ()
-(void) createScanViewController;//创建扫描控制器
- (void)scanAction;//扫描
@end

@implementation CSLScanViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    [self createScanViewController];
    self.navigationController.navigationBar.hidden= YES;
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self scanAction];
}
-(void) createScanViewController{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
            vc  = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
        });
//        vc.delegate = self;
    }
    else {
        [Auxiliary alertWithTitle:NSLocalizedString(@"alertTitle", nil) message:NSLocalizedString(@"scanReaderNotSupport", nil) button:1 done:nil];
    }
}
- (void)scanAction
{
    //    [self presentViewController:vc animated:YES completion:NULL];
    [self.view addSubview:vc.view];
    __weak CSLScanViewController*weakSelf = self;
    [vc setCompletionWithBlock:^(NSString * _Nullable resultAsString) {
        [Auxiliary alertWithTitle:NSLocalizedString(@"alertTitle", nil) message:resultAsString button:1 done:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

#pragma mark - QRCodeReader Delegate Methods
//取得扫描结果
//- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
//{
//    NSLog(@"%@",result);
//    [reader stopScanning];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
////按下cancel按钮
//- (void)readerDidCancel:(QRCodeReaderViewController *)reader
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

@end
