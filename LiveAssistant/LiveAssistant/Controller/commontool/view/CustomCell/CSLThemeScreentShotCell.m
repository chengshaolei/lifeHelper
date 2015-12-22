//
//  CSLTranlationModel.h
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLThemeScreentShotCell.h"

@implementation CSLThemeScreentShotCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _screenShotImgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 180)];
        [self addSubview:_screenShotImgView];
        
        _lblthemeName=[[UILabel alloc] initWithFrame:CGRectMake(140, 70, 170, 40)];
        [_lblthemeName setBackgroundColor:[UIColor clearColor]];
        [_lblthemeName setFont:[UIFont fontWithName:@"Hevtical" size:25]];
        [_lblthemeName setFont:[UIFont boldSystemFontOfSize:20]];
        [self addSubview:_lblthemeName];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
