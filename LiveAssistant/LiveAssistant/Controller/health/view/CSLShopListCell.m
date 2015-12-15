//
//  CSLShopListCell.m
//  LiveAssistant
//
//  Created by csl on 15/12/15.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLShopListCell.h"
#import "CSLShopListModel.h"

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
    _countLabel.text = [NSString stringWithFormat:@"%ld",model.count];
}
@end
