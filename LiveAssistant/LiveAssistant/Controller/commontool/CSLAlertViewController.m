//
//  CSLAlertViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLAlertViewController.h"
#import "CSLAddAlarmViewController.h"
#import "APService.h"
#import "CSLUser.h"
#import "Auxiliary.h"
#import "AppDelegate.h"
#import "CSLTabBarController.h"
#import "CSLDataBase.h"
@interface CSLAlertViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *alermTableView;
@property(nonatomic,strong) NSMutableArray * alarms;//存储闹钟

-(void) setupUI;//创建界面
-(void) addAlarm;//增加闹钟
-(void) quaryAlarm;//查询所有闹钟
-(void) switchToLogin;//转到登录
@end

@implementation CSLAlertViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.alarms = nil;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self quaryAlarm];
}

-(void) setupUI{
    self.navigationItem.title = NSLocalizedString(@"alertController", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlarm)];
    //创建数据源
    self.alarms = [[NSMutableArray alloc] init];
    self.alermTableView.editing = YES;//进入编辑模式
}

//增加闹钟
-(void) addAlarm{
    if ([[CSLUser shareInstance] isLoginedUser]) {//检测用户是否登录，登录用户才允许增加闹钟
        CSLAddAlarmViewController * alarmController = [[CSLAddAlarmViewController alloc] init];
        [self.navigationController pushViewController:alarmController animated:YES];
    }
    else{//未登录
        [self switchToLogin];
    }
}

//查询闹钟
-(void) quaryAlarm{
    
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    [_alarms removeAllObjects];
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[@"alarmKey"];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [_alarms addObject:userInfo];
            }
        }
    }

    if (_alarms.count>0) {
        [self.alermTableView reloadData];
    }
}

-(void) switchToLogin{
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    __weak  CSLTabBarController *tabController = delegate.tabBarController;
    [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:@"user not login" button:1 done:^{
        //转到登录界面
        tabController.selectedIndex = 3;
    }];
}
#pragma mark------表的数据源和代理 ——----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _alarms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alarmcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"alarmcell"];
    }
    
    cell.textLabel.text = _alarms[indexPath.row][@"time"];
    cell.detailTextLabel.text = _alarms[indexPath.row][@"repeat"];
    return cell;
}

//选中cell
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//删除cell
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
