//
//  CSLExpressViewController.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLExpressViewController.h"
#import "CSLConstant.h"
#import "CSLNetRequest.h"
#import "CSLComBoxView.h"
#import "CSLDataBase.h"
#import "CSLExpressCompany.h"
#import "CSLExpressModel.h"
#import "CSLExpressDetailController.h"

@interface CSLExpressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UITextField *expressOrderTextField;
-(void) initDownlistView;//初始化下拉列表框
@end

@implementation CSLExpressViewController
{
    IBOutlet UITableView * _tableView;
    CSLComBoxView * _comBox;//下拉列表
    NSArray * _allCompany;//快递公司
}
@synthesize dataSource = _dataSource;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initDownlistView];
//    [self downlistViewAutolayout];
//    NSLog(@"%@",NSHomeDirectory());
//    NSString * txtPath = [[NSBundle mainBundle] pathForResource:@"express" ofType:@"txt"];
//    //[[CSLDBManager defaultDBManager] isTableOK:<#(NSString *)#>]
//    __autoreleasing NSError * error;
//    NSString * string = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:&error];
//    NSArray * lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//    for (NSString * line in lines) {
//        NSArray * arr = [line componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        [[CSLDBManager defaultDBManager] insertTable:@"expresscompany" record:@{@"shortname":arr[0],@"name":arr.lastObject}];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initDownlistView{
    _comBox = [[CSLComBoxView alloc] initWithFrame:CGRectMake(102, 85, 100, 40)];
    _comBox.textField.placeholder = @"请点击查询";
    [self.view addSubview:_comBox];
    _allCompany = [[CSLDBManager defaultDBManager] select:@"select shortname,name from expresscompany" where:nil];
    NSMutableArray * comps = [NSMutableArray array];
    for (NSDictionary * dict in _allCompany) {
        [comps addObject:dict[@"name"]];
    }
    _comBox.tableArray = comps;
 }
- (IBAction)findExpressNo:(id)sender {
    NSString * no = self.expressOrderTextField.text;
    NSString * com = _comBox.textField.text;
    if (no.length<=0 || com.length<=0) {
        return;
    }
    NSString * condition = [NSString stringWithFormat:@"name = \"%@\"",com];
    NSString * shortName = [[CSLDBManager defaultDBManager] getStringValue:@"expresscompany" withFieldName:@"shortname" where:condition];
    if (shortName) {//找到
        //[self loadDataWithCompany:shortName no:no];
        CSLExpressDetailController * detailController = [[CSLExpressDetailController alloc] init];
        detailController.shortName = shortName;
        detailController.expressNo = no;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

@end
