//
//  CSLDrugDetailController.m
//  LiveAssistant
//
//  Created by csl on 15/12/17.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDrugDetailController.h"
#import "CSLDrugListModel.h"
#import "CSLDrugDetailCell.h"
#import "NSObject+perpoty.h"
#import "UIImageView+AFNetworking.h"

#define DrugDetailCell1 @"DrugDetailCell1"
#define DrugDetailCell2 @"DrugDetailCell2"

@interface CSLDrugDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

-(void) DetailControllerInit;//数据初始化
@end

@implementation CSLDrugDetailController
{
    NSArray * sectionList;//section的header
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药品详情";
    [self DetailControllerInit];
    sectionList = @[@"简介",@"成份",@"主治",@"用法",@"注意事项"];
     UILabel * header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 30)];
    header.text = _drugInfo.name;
    self.myTableView.tableHeaderView = header;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) DetailControllerInit{
    NSArray * propertyNames = [_drugInfo getAllProperties];
    for (NSString*key in propertyNames) {
        id obj = [_drugInfo valueForKey:key];
        if (obj==nil||[obj isEqual:[NSNull null]]) {
            [_drugInfo setValue:@"" forKey:key];
        }
    }
    
    //添加数据源
    _drugInfo.name = [NSString stringWithFormat:@"药品名称：%@",_drugInfo.name];
    _drugInfo.factory =[NSString stringWithFormat:@"产地：%@",_drugInfo.factory];
    _drugInfo.pizhun = [NSString stringWithFormat:@"国药（字）：%@",_drugInfo.pizhun];
    self.dataSource[0]=@{@"name":_drugInfo.name,@"factory":_drugInfo.factory,@"pizhun":_drugInfo.pizhun};
    [self.dataSource addObject: _drugInfo.ingredients];
    [self.dataSource addObject: _drugInfo.function];
    [self.dataSource addObject: _drugInfo.use];
    
    _drugInfo.attention = [NSString stringWithFormat:@"注意：%@",_drugInfo.attention];
    _drugInfo.forbidden = [NSString stringWithFormat:@"禁忌：%@",_drugInfo.forbidden];
    _drugInfo.bad = [NSString stringWithFormat:@"不良反应：%@",_drugInfo.bad];
    [self.dataSource addObject:@[_drugInfo.attention,_drugInfo.forbidden,_drugInfo.bad]];

    [self.myTableView registerNib:[UINib nibWithNibName:@"CSLDrugDetailCell" bundle:nil] forCellReuseIdentifier:DrugDetailCell1];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DrugDetailCell2];
}

#pragma mark--------UITableViewDatasource------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (4==section) {
        return 3;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CSLDrugDetailCell *
        cell = [tableView dequeueReusableCellWithIdentifier:DrugDetailCell1];
        cell.nameLabel.text = _drugInfo.name;
        cell.nameLabel.numberOfLines = 0;
        cell.factoryLabel.text = _drugInfo.factory;
        cell.pizhunLabel.text = _drugInfo.pizhun;
        
        return cell;
    }
    else{
       UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:DrugDetailCell2];
        cell.textLabel.numberOfLines = 0;
        if (indexPath.section!=4) {
            cell.textLabel.text = self.dataSource[indexPath.section];
        }
        else{
            cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    
    return nil;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = indexPath.section;
    if (0==section) {
        return 96;
    }
    else{
        NSString * text;
        if (4==section) {
            text = self.dataSource[indexPath.section][indexPath.row];
        }
        else{
            text = self.dataSource[indexPath.section];
        }
        
        if (text.length>0) {
            CGRect rect = [text boundingRectWithSize:CGSizeMake(tableView.frame.size.width-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
            return rect.size.height+10;
        }
    }
    return 0;
}

//自定义sectionheader
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    titleLabel.text = sectionList[section];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blueColor];
    return titleLabel;
}



@end
