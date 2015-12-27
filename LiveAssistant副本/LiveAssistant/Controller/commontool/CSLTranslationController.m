//
//  CSLTranslationController.m
//  LiveAssistant
//
//  Created by csl on 15/12/20.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLTranslationController.h"
#import "CSLTranlationModel.h"
#define TanslationCellReuse @"TanslationCellReuse"

@interface CSLTranslationController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *translateTableView;


-(void) translationInit;//初始化
-(void) requestData:(NSString*)word;//查询数据
-(void) standardData:(CSLTranlationModel*)model;//数据标准化


@end

@implementation CSLTranslationController
{
    NSArray * _titles;//section标题
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self translationInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化
-(void) translationInit{
    self.navigationItem.title = NSLocalizedString(@"youdao", nil) ;//@"有道翻译";
    self.navigationController.navigationBar.translucent = NO;
    _titles = @[NSLocalizedString(@"translation", nil),NSLocalizedString(@"basic", nil),NSLocalizedString(@"web", nil)];
    
    //注册cell
    [self.translateTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TanslationCellReuse];
}

//查询数据
-(void) requestData:(NSString*)word{
    [self JHRequestWithAPPid:@"111" method:@"GET" url:JH_Translation_URL paras:@{@"key":@"68f8dd63c274b34a7e8516c6152b731d",@"word":word}];
}

//将返回的数据规范化
-(void) standardData:(CSLTranlationModel*)model{
    model.translation = model.translation?model.translation:@[@""];
    [self.dataSource addObject:model.translation];
    
    //将basic内容转换成数组加到数据源
    NSDictionary * dict = [model.basic toDictionary];
    NSMutableArray * arrs = [NSMutableArray array];
    for (NSString*key in dict) {
        if ([key isEqualToString:@"explains"]==NO) {
            //@{key:dict[key]
            [arrs addObject:[NSString stringWithFormat:@"%@：%@",NSLocalizedString(key,nil),dict[key]?dict[key]:@""]];
        }
        else{
            NSString * string = [model.basic.explains componentsJoinedByString:@"\n"];
            [arrs addObject:[NSString stringWithFormat:@"%@：%@",NSLocalizedString(key,nil),string?string:@""]];
        }
    }
    
    [self.dataSource addObject:arrs];
    
    NSMutableArray * webs = [NSMutableArray array];
    for (NSDictionary *web in model.web) {
        NSMutableString *str = [[NSMutableString alloc] init];
        
        [str appendFormat:@"%@：\n",web[@"key"]?web[@"key"]:@""];
        [str appendFormat:@"%@",[web[@"value"] componentsJoinedByString:@"\n"]];
        [webs addObject:str];
    }
    [self.dataSource addObject:webs];
}
-(void) parserData:(id)data{
    [self.dataSource removeAllObjects];
    if ([data[@"reason"] isEqualToString:@"Success"]) {
        NSDictionary * result = data[@"result"];
        if (result&&result.count>0) {
            NSDictionary * info = result[@"data"];
            if (info&&info.count>0) {
                __autoreleasing NSError *error;
                CSLTranlationModel * word = [[CSLTranlationModel alloc] initWithDictionary:info error:&error];
                if (!error) {
                    [self standardData:word];
                    [self.translateTableView reloadData];//刷新表
                }
            }
        }
    }
}

#pragma mark--------表的代理------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:TanslationCellReuse];
    NSUInteger section = indexPath.section;
    cell.textLabel.text = self.dataSource[section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.numberOfLines = 0;
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld  %ld",indexPath.section,indexPath.row);
    NSString * str = self.dataSource[indexPath.section][indexPath.row];
    return [Auxiliary dynamicHeightWithString:str width:tableView.frame.size.width attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}]+10;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _titles[section];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
#pragma mark----UISeachBarDeleagae-------

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.dataSource removeAllObjects];
    [self.translateTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchTerm:searchBar.text];
}
-(void) searchTerm:(NSString*)text{
    
    [self.dataSource removeAllObjects];
    [self.translateTableView reloadData];
    
    //去除空格
    NSString * str = [text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    if (str.length<=0) {
        self.searchBar.text = @"";
        [self.searchBar becomeFirstResponder];
        return;
    }
    [self.searchBar resignFirstResponder];
    [self requestData:str];
}

@end



