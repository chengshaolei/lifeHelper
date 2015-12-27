//
//  CSLShopListCell.m
//  LiveAssistant
//
//  Created by csl on 15/12/15.
//  Copyright © 2015年 CSL. All rights reserved.
//
#define ImageBaseURL @"http://tnfs.tngou.net/image"
#import "CSLShopListCell.h"
#import "CSLShopListModel.h"
#import "UIImageView+AFNetworking.h"


@implementation CSLShopListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setModel:(CSLShopListModel *)model{
    _nameLabel.text = model.name;
    _countLabel.text = [NSString stringWithFormat:@"访问量：%ld",model.count];
    if (model.img&&model.img.length>0) {
         NSString * urlString = [NSString stringWithFormat:@"%@%@",ImageBaseURL,model.img];
        [_logoImageView setImageWithURL:[NSURL URLWithString:urlString]];
    }
   
}
@end
