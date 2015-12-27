//
//  CSLFlashlightViewController.h
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLBaseViewController.h"

@class AVCaptureDevice;
@interface CSLFlashlightViewController : CSLBaseViewController
{
    BOOL isLightOn;
    AVCaptureDevice *device;
}
@property(nonatomic) BOOL isLightOn;
@end
