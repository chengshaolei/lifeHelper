//
//  CSLAddAlarmViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/27.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLAddAlarmViewController.h"
#import "CSLRepeatSelectView.h"
#import "APService.h"
#import "Auxiliary.h"
#import "CSLUser.h"

@interface CSLAddAlarmViewController ()<UITableViewDataSource,UITableViewDelegate>
-(void) setupUI;//初始化界面
@property (weak, nonatomic) IBOutlet UITableView *alarmTable;
@end

@implementation CSLAddAlarmViewController{
    RepeatMode  selectedMode;//选中的模式
    NSString * selectedTitle;//闹钟标题
    NSString * time;//闹钟时间
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setupUI{
    self.navigationItem.title  = NSLocalizedString(@"Add Alarm", nil);
    
    //保存按钮
    UIImage *image = [UIImage imageNamed:@"correct.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
}

#pragma mark-------------数据源代理-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellreuseindentifier"];
    NSUInteger row = indexPath.row;
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellreuseindentifier"];
        switch (row) {
            case 0:
            {
                UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
                datePicker.datePickerMode = UIDatePickerModeTime;//时间模式
                datePicker.tag = 1001;
                [datePicker addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventValueChanged];
                [cell addSubview:datePicker];
            }
                break;

                break;
            case 3:
            {
                UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
                btn.frame = CGRectMake(0, 0, tableView.frame.size.width, 44);
                [btn setTitle:NSLocalizedString(@"delete a alarm", nil) forState:UIControlStateNormal];
                btn.tag = row;
                [btn addTarget:self action:@selector(deleteAlarm:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
                break;
            default:
                break;
        }

    }
    if (1==row) {
        cell.textLabel.text = NSLocalizedString(@"repeat interval", nil);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if(2==row){
        cell.textLabel.text = NSLocalizedString(@"title label", nil);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0==indexPath.row) {
        return 217;
    }
    else{
        return 44;
    }
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==1) {
        selectedMode = (RepeatMode)-1;
        CSLRepeatSelectView * selectedView = [[CSLRepeatSelectView alloc] initWithFrame:self.view.frame];
        [selectedView showinView:self.view.window complete:^(RepeatMode selected) {
            selectedMode = selected;
        }];
        
    }
    else if (2==indexPath.row){
        UIAlertController * titleController = [UIAlertController alertControllerWithTitle:@"标题" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [titleController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"titletint", nil);
        }];
        [titleController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = NSLocalizedString(@"bodytint", nil);
        }];
        __weak UIAlertController * weakController = titleController;
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"buttonok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField * titleField = weakController.textFields[0];
            selectedTitle = titleField.text;
        }];
        [titleController addAction:okAction];
        [self presentViewController:titleController animated:YES completion:nil];
    }
}

#pragma mark----时间处理--------------------
-(void) selectTime:(UIDatePicker*)sender{//日期选择器处理
    time = nil;
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"HH:mm"];
    time = [dateFormater stringFromDate:sender.date];
}

//保存闹钟
-(void) save:(id)sender{
    if (!time ||time.length<=0) {
        UIDatePicker * picker = [self.alarmTable viewWithTag:1001];
        [self selectTime:picker];
    }
    
    
    if ((NSInteger)selectedMode<0) {
        NSLog(@"error");
        [Auxiliary alertWithTitle:@"reminder" message:NSLocalizedString(@"repeatmodetint", nil) button:1 done:nil];
        return;
    }
    
    //"only one" = "只此一次";
//    "monday~friday" = "周一到周五";
//    "everyday" = "每一天";
    NSArray * repeatModes = @[NSLocalizedString(@"only one", nil),NSLocalizedString(@"monday~friday", nil),NSLocalizedString(@"everyday", nil)];
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyy-MM-dd"];
    NSString * currentDateString = [dateFormater stringFromDate:[NSDate date]];
    currentDateString = [currentDateString stringByAppendingFormat:@" %@",time];
    [dateFormater setDateFormat:@"yyy-MM-dd HH:mm"];
    NSLog(@"%@",[dateFormater stringFromDate:[NSDate date]]);
    
    //当地时间
    NSDate * date = [dateFormater dateFromString:currentDateString];
    NSString *indentifier = [NSString stringWithFormat:@"%@%@",[CSLUser shareInstance].userName,[dateFormater stringFromDate:[NSDate date]]];
    
    if (!selectedTitle) {//如果标题为空，设置默认标题
        selectedTitle = currentDateString;
    }
   [APService setLocalNotification:date alertBody:@"hello world" badge:1 alertAction:NSLocalizedString(@"buttonok", nil) identifierKey:indentifier userInfo:@{@"alarmKey":indentifier,@"time":time,@"title":selectedTitle,@"repeat":repeatModes[selectedMode]} soundName:nil region:nil regionTriggersOnce:NO category:nil];
    [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"alermsave", nil) button:1 done:nil];
    
    __weak CSLAddAlarmViewController *wealSelf = self;
    [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"alermsave", nil) button:1 done:^{
        [wealSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

//按钮处理
-(void) deleteAlarm:(id)sender{
    NSLog(@"aaaa");
}

@end
