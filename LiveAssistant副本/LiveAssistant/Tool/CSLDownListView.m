//
//  CSLDownListView.m
//  LiveAssistant
//
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import "CSLDownListView.h"
#define cellReuserQueueIndentifier @"downlistCell"
#define ListViewHeight 140
BOOL isExpand = NO;//列表是否展开

@interface CSLDownListView()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
-(void) createInterface;//创建界面
-(void) restoreOrigion:(BOOL)flag;//恢复视图的初始样式
-(void) layoutView;//自动布局
@end
@implementation CSLDownListView
@synthesize inputTextField = _inputTextField;
@synthesize listView = _listView;
@synthesize dataSource = _dataSource;

-(instancetype) init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self createInterface];
    }
    return self ;
}

//初始化方法重写
-(instancetype) initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        if (frame.size.height>40) {
            frame.size.height = 0;
        }
        self.frame = frame;
        [self createInterface];//构建界面
    }
    return self;
}

-(void) setDataSource:(NSArray*)source{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    else{
        [_dataSource removeAllObjects];
    }
    [_dataSource addObjectsFromArray:source];
}

-(BOOL) addItem:(NSString*)item{
    [self addItem:item atIndex:ULONG_MAX];
    return YES;
}

-(BOOL) addItem:(NSString*)item atIndex:(NSUInteger)index
{
    //如果插入的位置大于数组元素个数
    if (index>=_dataSource.count) {
        [_dataSource addObject:item];
    }
    else{//否则
        [_dataSource insertObject:item atIndex:index-1];
    }
    [self.listView reloadData];
    return YES;
}

-(void) createInterface{
    
    //创建输入框
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
   
    self.inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTextField.placeholder = NSLocalizedString(@"placeholdtext", nil);
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:self action:@selector(downList:) forControlEvents:UIControlEventTouchUpInside];
    self.inputTextField.rightView = rightButton;
    self.inputTextField.rightViewMode = UITextFieldViewModeAlways;//总显示
    self.inputTextField.delegate = self;
    [self addSubview:self.inputTextField];
    
    //创建列表
    self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y+45, self.frame.size.width, 0)];
     self.listView.dataSource = self;
    self.listView.delegate = self;
    self.listView.rowHeight = 30;
    self.listView.layer.borderWidth = 1;
    self.listView.layer.borderColor = [UIColor grayColor].CGColor;
    self.listView.hidden = YES;
    [self addSubview:self.listView];

    //自动布局
    [self layoutView];
}

//自动布局
-(void) layoutView{
    //取消automaskresize
    _inputTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _listView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //垂直布局
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_inputTextField]-1-[_listView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inputTextField,_listView)]];
    
    //水平布局
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_inputTextField]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inputTextField)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_listView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_listView)]];
}

#pragma mark-------表视图的数据源和代理方法------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",_dataSource.count);
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell的初始化
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReuserQueueIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuserQueueIndentifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    NSLog(@"%@",_dataSource[indexPath.row]);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

//处理选中
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * currentItem = _dataSource[indexPath.row];
    
    //将选中项填入输入框
    self.inputTextField.text = currentItem;
    
    //将选中项赋值给selectedItem
    self.selectedItem = currentItem;
    
    //恢复初始大小
    [self restoreOrigion:YES];
    isExpand = !isExpand;
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark------文本框代理-------------------------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


#pragma mark-------按钮处理--------------------------
-(void) downList:(UIButton*)sender{
    [self restoreOrigion:isExpand];//收缩或扩展列表
    isExpand = !isExpand;//修改标志位
    if (_done) {
        _done();
    }
}

//恢复视图的初始样式
-(void) restoreOrigion:(BOOL)flag{
    CGRect viewOriginFrame = self.frame;;
    CGRect listViewFrame = self.listView.frame;//得到下拉列表的frame
    int sign = flag?-1:1;
    viewOriginFrame.size.height += ListViewHeight*sign;
    listViewFrame.size.height += ListViewHeight*sign;
    self.frame = viewOriginFrame;//重新设置高度
    self.listView.frame = listViewFrame;
    self.listView.hidden = flag;
}
@end
