//
//  CSLTermController.m
//  LiveAssistant
//
//  Created by csl on 15/12/19.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLTermController.h"
#import "CSLTermModel.h"
#import "NSObject+perpoty.h"

#define TermCell @"TermCell"

@interface CSLTermController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *termTable;
@property (weak, nonatomic) IBOutlet UISearchBar *seachBar;
-(void) termInit;//初始化
-(void) requestData:(NSString*)text;//数据请求
-(void) searchTerm:(NSString*)text;//搜索成语
@end

@implementation CSLTermController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self termInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化
-(void) termInit{
    self.navigationItem.title = NSLocalizedString(@"dictionary of idioms", nil);
    self.navigationController.navigationBar.translucent = NO;
    
    //设置代理
    self.seachBar.delegate = self;
    self.seachBar.placeholder = NSLocalizedString(@"please input an idiom", nil);
    
    //注册cell
    [self.termTable registerClass:[UITableViewCell class] forCellReuseIdentifier:TermCell];
}
//数据请求
-(void) requestData:(NSString*)text{
    [self JHRequestWithAPPid:@"157" method:@"GET" url:JH_Idiom_URL paras:@{@"key":@"7d75ad7391527b5fa0c1e9aeebbc3979",@"word":text}];
}
-(void) parserData:(id)data{
    if (!data) {
        return;
    }
    
    if ([data[@"reason"] isEqualToString:@"success"]==NO) {
        [self.dataSource removeAllObjects];
        [self.termTable reloadData];
        return;
    }
    NSDictionary * result = data[@"result"];
    __autoreleasing NSError * error;
    CSLTermModel * term = [[CSLTermModel alloc] initWithDictionary:result error:&error];
    if (!error) {
        //构建数据源
        NSArray *keys = [term getAllProperties];
        [self.dataSource removeAllObjects];
        
        for (NSString *key in keys) {
            NSMutableString * content = [[NSMutableString alloc] init];
            
            //将此条中文键值加进来。
            [content appendFormat:@"%@：",NSLocalizedString(key, nil)];
        
            if ([key isEqualToString:@"fanyi"]==YES||[key isEqualToString:@"tongyi"]==YES) {
                //将数组转换成字符串加入数据源
                NSArray * arr = [term valueForKey:key];
                [content appendString:[arr componentsJoinedByString:@";"]];//追加词条的值
            }
            else{
                [content appendString:[term valueForKey:key]];
            }
            [self.dataSource addObject:content];
        }
        [self.termTable reloadData];//刷新表
    }
}

#pragma mark--------UITableViewDelegate---------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TermCell];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Auxiliary dynamicHeightWithString:self.dataSource[indexPath.row] width:tableView.frame.size.width attribute:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}]+10;
}

#pragma mark----UISeachBarDeleagae-------
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    [self searchTerm:searchBar.text];
//}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.dataSource removeAllObjects];
    [self.termTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchTerm:searchBar.text];
}
-(void) searchTerm:(NSString*)text{
    
    [self.dataSource removeAllObjects];
    [self.termTable reloadData];
    
    //去除空格
    NSString * str = [text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    if (str.length<=0) {
        self.seachBar.text = @"";
        [self.seachBar becomeFirstResponder];
        return;
    }
    [self.seachBar resignFirstResponder];
    [self requestData:str];
}
@end
