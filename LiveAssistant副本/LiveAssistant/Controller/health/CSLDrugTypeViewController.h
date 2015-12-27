//
//  CSLDrugTypeViewController.h
//  LiveAssistant
//
//  Created by csl on 15/12/16.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLBaseViewController.h"
@class CSLDrugTypeLeftController;
@class CSLDrugTypeDetailViewController;

@interface CSLDrugTypeViewController : CSLBaseViewController
@property(nonatomic,strong)CSLDrugTypeLeftController * LeftController;
@property(nonatomic,strong)CSLDrugTypeDetailViewController * rightController; 
@end
