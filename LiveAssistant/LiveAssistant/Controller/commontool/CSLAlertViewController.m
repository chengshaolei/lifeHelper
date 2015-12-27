//
//  CSLAlertViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLAlertViewController.h"
#import "APService.h"

@interface CSLAlertViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *alermTableView;
@property(nonatomic,strong) NSMutableArray * alarms;//存储闹钟

-(void) setupUI;//创建界面
-(void) addAlarm;//增加闹钟
@end

@implementation CSLAlertViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.alarms = nil;
}

-(void) setupUI{
    self.navigationItem.title = NSLocalizedString(@"alertController", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlarm)];
}

//增加闹钟
-(void) addAlarm{
    
}

#pragma mark------表的数据源和代理 ——----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _alarms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
