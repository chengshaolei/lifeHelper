//
//  CSLDrugListCell.h
//  LiveAssistant
//
//  Created by csl on 15/12/17.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSLDrugListModel;//模型
@interface CSLDrugListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *drugNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *piZhunLabel;

@property(nonatomic,strong) CSLDrugListModel * model;//给cell赋值

@end
