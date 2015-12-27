//
//  HQCollectionViewCell.h
//  weather
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 XuJianQiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSLCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *Date;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *Temp;

@end
