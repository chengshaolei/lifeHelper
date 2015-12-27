//
//  CSLRepeatSelectView.m
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLRepeatSelectView.h"

@interface CSLRepeatSelectView ()<UITableViewDelegate,UITableViewDataSource>
-(void) setupUI;//搭建界面
@end

@implementation CSLRepeatSelectView
{
    UITableView * _tableView;
    NSArray * _dataSource;
}

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
        _dataSource = @[@"只此一次",@"周一到周五",@"每一天",@""];
    }
    return self;
}

-(void) setupUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-100, self.frame.size.height-200)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    _tableView.center = self.center;
    _tableView.layer.cornerRadius = 10;
    _tableView.layer.masksToBounds = YES;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    label.text = @"重复模式";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    _tableView.tableHeaderView = label;
}

#pragma mark----UITableViewDatasource------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
        if (3==indexPath.row) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame  = CGRectMake(10, 5, tableView.frame.size.width-20, 30);
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (3!=indexPath.row) {
        self.mode = (RepeatMode)indexPath.row;
        if (_choose) {
            _choose((RepeatMode)indexPath.row);
        }
    }
    [self dismissView:nil];
}

-(void) dismissView:(id)sender{
    [self removeFromSuperview];
}

-(void) showinView:(UIView*)parentView complete:(SeclectCallBack)complete{
    
    _choose = complete;
    [parentView addSubview:self];
}
@end
