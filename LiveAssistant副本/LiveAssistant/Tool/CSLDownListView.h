//
//  CSLDownListView.h
//  LiveAssistant
//  实现下拉列表框
//  Created by csl on 15/12/10.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickCallBack)();

//下拉列表框由输入框和下拉列表组合实现
@interface CSLDownListView : UIView
@property(nonatomic,strong) UITextField * inputTextField;//输入框
@property(nonatomic,strong) UITableView * listView;//下拉列表
@property(nonatomic,strong) NSMutableArray * dataSource;//列表框的数据源
@property(nonatomic,strong)NSString* selectedItem;//当前选中项
@property(nonatomic,copy) ClickCallBack done;

//方法

//功能：给列表框增加一项数据
//参数：item 要增加的字符串
//返回值：成功返回YES，失败返回NO
-(BOOL) addItem:(NSString*)item;


//功能：给列表框增加一项数据
//参数：item 要增加的字符串
//     index 插入位置
//返回值：成功返回YES，失败返回NO
-(BOOL) addItem:(NSString*)item atIndex:(NSUInteger)index;
@end
