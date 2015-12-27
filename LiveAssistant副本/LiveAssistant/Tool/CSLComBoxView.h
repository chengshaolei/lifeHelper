//
//  CsLComBoxView.h
//  LiveAssistant
//
//  Created by csl on 15/12/23.
//  Copyright © 2015年 CSL. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^SelectedCallBack)();

@interface CSLComBoxView : UIView<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tv;//下拉列表
    NSMutableArray *tableArray;//下拉列表数据
    UITextField *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UITextField *textField;
//@property(nonatomic,copy) SelectedCallBack done;
@end
