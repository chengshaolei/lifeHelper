//
//  CSLShopListCell.h
//  LiveAssistant
//
//  Created by csl on 15/12/15.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSLShopListModel;
@interface CSLShopListCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UIImageView * logoImageView;
@property(nonatomic,weak) IBOutlet UILabel * nameLabel;
@property(nonatomic,weak) IBOutlet UILabel * countLabel;
@property(nonatomic,strong) CSLShopListModel * model;
@end
