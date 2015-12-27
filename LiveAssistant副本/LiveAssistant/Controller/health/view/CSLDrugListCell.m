//
//  CSLDrugListCell.m
//  LiveAssistant
//
//  Created by csl on 15/12/17.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugListCell.h"
#import "CSLDrugListModel.h"
#import "UIImageView+AFNetworking.h"


@implementation CSLDrugListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setModel:(CSLDrugListModel *)model{
    if (model) {
        if (model.coverUrl&&model.coverUrl.length>0) {
            NSURL * url = [NSURL URLWithString:model.coverUrl];
            [self.imageView setImageWithURL:url];
        }
        self.drugNameLabel.text = model.name;
        self.piZhunLabel.text = model.pizhun;
        
    }
}
@end
