//
//  CSLCheckCodeView.m
//  登陆验证
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//

#import "CSLCheckCodeView.h"

@implementation CSLCheckCodeView
{
    NSMutableString * _checkCode;
}
-(void) createCode{
    //生成验证码
    [_checkCode setString:@""];
    for (int i = 0; i<4; i++) {
        char ch = 33+arc4random()%95;
        if (isalpha(ch)||isdigit(ch)) {
            [_checkCode appendFormat:@"%c",ch];
        }
        else{
            i--;
        }
        
    }
    [self setTitle:_checkCode forState:UIControlStateNormal];
}
-(void) awakeFromNib{
    _checkCode = [NSMutableString string];
    [self createCode];//生成验证码
    [self addTarget:self action:@selector(createCode) forControlEvents:UIControlEventTouchUpInside];
}
-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _checkCode = [NSMutableString string];
        [self createCode];//生成验证码
        [self addTarget:self action:@selector(createCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(BOOL) check:(NSString*)code{
    return [_checkCode isEqualToString:code];
}
@end
