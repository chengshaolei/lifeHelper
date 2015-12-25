//
//  CSLRegisterViewController.m
//  登陆验证
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//

#import "CSLRegisterViewController.h"
#import "CSLUser.h"
#import "Auxiliary.h"

@interface CSLRegisterViewController ()
-(void) createUI;//构建注册界面
-(void) registerUser:(id)sender;//用户注册
-(void) cancel:(id)sender;
-(BOOL) check;//检查用户名和密码是否为空
@end

@implementation CSLRegisterViewController
{
    UITextField * _nameTextField;
    UITextField * _passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //构建界面
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 释放对象
    _nameTextField = nil;
    _passwordTextField = nil;
}

-(void) createUI{
    //用户名标签
    UILabel * l1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 80, 30)];
    l1.text = @"用户名：";
    [self.view addSubview:l1];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(l1.frame.origin.x+l1.frame.size.width + 10, l1.frame.origin.y, self.view.frame.size.width-l1.frame.size.width-60, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.backgroundColor = [UIColor cyanColor];
    _nameTextField.clearsOnBeginEditing = YES;
    [self.view addSubview:_nameTextField];
    
    //密码
    UILabel * l2 = [[UILabel alloc] initWithFrame:CGRectMake(30, l1.frame.origin.y+l1.frame.size.height+20, 80, 30)];
    l2.text = @"密码：";
    [self.view addSubview:l2];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(l2.frame.origin.x+l2.frame.size.width + 10, l2.frame.origin.y, self.view.frame.size.width-l2.frame.size.width-60, 30)];
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordTextField.backgroundColor = [UIColor cyanColor];
    _passwordTextField.clearsOnBeginEditing = YES;
    [self.view addSubview:_passwordTextField];
    
    //确定按钮
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    okButton.frame = CGRectMake(100, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+30, 60, 30);
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(240, _passwordTextField.frame.origin.y+_passwordTextField.frame.size.height+30, 60, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];

}

-(void) registerUser:(id)sender{
    //验证用户名和密码是否合法
    if ([self check]==NO) {
        return;
    };
    
    if ([[CSLUser shareInstance] registerUser:_nameTextField.text password:_passwordTextField.text]) {
        NSDictionary * dict = @{@"name":_nameTextField.text,
                                @"password":_passwordTextField.text};
        NSNotificationCenter *nc =[NSNotificationCenter defaultCenter];
        
        //name 通知名字， object通知者 userinfo通知内容
        [nc postNotificationName:@"registerUserInfo" object:nil userInfo:dict];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [Auxiliary alertWithTitle:@"失败" message:@"注册失败！" button:1 done:nil];
    }
    
   
}
-(void) cancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) check{
    NSString * name = _nameTextField.text;
    NSString * pwd = _passwordTextField.text;
    
    //去掉空格回车
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    pwd = [pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //验证用户名
    if (name.length<=0) {
        _nameTextField.text = @"";//清空内容
        [_nameTextField becomeFirstResponder];//重新获得焦点
        return NO;
    }
    
    //验证密码
    if (pwd.length<=0) {
        [_passwordTextField becomeFirstResponder];
        _passwordTextField.text = @"";
        return NO;
    }
    return YES;
}
@end
