//
//  CSLVocabularyController.m
//  LiveAssistant
//
//  Created by csl on 15/12/19.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLVocabularyController.h"
#import "CSLConstant.h"
#import "Auxiliary.h"
#import "CSLVocabularyModel.h"

#define VocabularyCell  @"VocabularyCell1"

@interface CSLVocabularyController()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *vocabularyTextField;
@property (weak, nonatomic) IBOutlet UITableView *vocabularyTable;
@property (weak, nonatomic) IBOutlet UIView *baseInfoView;
@property (weak, nonatomic) IBOutlet UILabel *pinyinLabel;
@property (weak, nonatomic) IBOutlet UILabel *bushouLabel;
@property (weak, nonatomic) IBOutlet UILabel *wubiLabel;
@property (weak, nonatomic) IBOutlet UILabel *bihuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *sequenceLabel;


-(void) vocabularyInit;//初始化
-(void) RequestData;//加载数据
-(void) setupBaseInfo;//设置基础信息
@end
@implementation CSLVocabularyController{
    CSLVocabularyModel * _word;//字的信息
    NSArray * _sectionTitles;//标题
}
-(void) viewDidLoad{
    [super viewDidLoad];
    [self vocabularyInit];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _word = nil;
    _sectionTitles = nil;
}


//数据初始化
-(void) vocabularyInit{
    self.title = @"新华字典";
    self.vocabularyTextField.delegate = self;
    self.vocabularyTextField.returnKeyType = UIReturnKeyGoogle;
    [Auxiliary layerCornerRadius:self.baseInfoView.layer radius:5 width:1 color:[UIColor grayColor]];//设置视图圆角
    
    [self.vocabularyTable registerClass:[UITableViewCell class] forCellReuseIdentifier:VocabularyCell];//注册cell
    _sectionTitles = @[@"基础解释",@"详细解释"];
}

//设置基础信息
-(void) setupBaseInfo{
    self.pinyinLabel.text = [NSString stringWithFormat:@"拼音：%@",_word.pinyin];
    self.wubiLabel.text = [NSString stringWithFormat:@"五笔：%@",_word.wubi];
    self.bushouLabel.text = [NSString stringWithFormat:@"部首：%@",_word.bushou];
    self.bihuaLabel.text = [NSString stringWithFormat:@"笔画：%@",_word.bihua];
    self.sequenceLabel.text = _word.sequence;
}

//数据请求
-(void) RequestData{
    self.isLoadIndicator = YES;
    [self showIndicatorInView:self.navigationController.view isDisplay:YES];
    NSString * searchText = [NSString stringWithUTF8String:[self.vocabularyTextField.text UTF8String]];
    [self JHRequestWithAPPid:@"156" method:@"GET" url:JH_Dictionary_URL paras:@{@"key":@"ed07031621b19377c2f78f3968f32fdf",@"word":searchText}];
}
-(void) parserData:(id)data{
    [self showIndicatorInView:self.navigationController.view isDisplay:NO];
    if ([data[@"error_code"] integerValue]==0) {//成功
        NSDictionary * result = data[@"result"];
        if (result) {
            __autoreleasing NSError * error;
            _word = [[CSLVocabularyModel alloc] initWithDictionary:result error:&error];
            if (!error) {//有数据
                [self.dataSource removeAllObjects];//移除原来数据
                _word.sequence = [_word.jijie lastObject];//加入笔画顺序
               [self setupBaseInfo];
                
                //把简介和详情加入数据源
                [self.dataSource addObject:_word.jijie];
                [self.dataSource addObject:_word.xiangjie];
                [self.vocabularyTable reloadData];
            }
        }
    }
}

#pragma mark-----UITextFieldDelegate-------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self RequestData];//请求数据
    return YES;
}

#pragma mark---------UITableViewDelegate-------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:VocabularyCell];
    NSString * str = self.dataSource[indexPath.section][indexPath.row];
    str = str?str:@"";
    cell.textLabel.text =str;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

//section标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sectionTitles[section];
}

//行高
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * string = self.dataSource[indexPath.section][indexPath.row];
    return [Auxiliary dynamicHeightWithString:string width:tableView.frame.size.width attribute:@{NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter" size:13]}]+10;
}
@end
