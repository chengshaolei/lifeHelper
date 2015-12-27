//
//  CSLDrugDetailCell.h
//  LiveAssistant
//
//  Created by csl on 15/12/18.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLDrugDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *factoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *pizhunLabel;

@end
