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

@interface CSLRegisterViewController ()<UITextFieldDelegate>
-(IBAction) registerUser:(id)sender;//用户注册
-(IBAction) cancel:(id)sender;
-(BOOL) check;//检查用户名和密码是否为空
@end

@implementation CSLRegisterViewController
{
    IBOutlet UITextField * _nameTextField;
    IBOutlet UITextField * _passwordTextField;
    IBOutlet UITextField * _confirmPasswordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"register", nil);
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 释放对象
    _nameTextField = nil;
    _passwordTextField = nil;
    _confirmPasswordTextField = nil;
}


-(IBAction) registerUser:(id)sender{
    //验证用户名和密码是否合法
    if ([self check]==NO) {
        return;
    };
    
    NSString * name = _nameTextField.text;
    
    //用户名不能和已有用户名重名
    if([[CSLUser shareInstance] isDuplicateName:name]){
        [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"duplicatename", nil) button:1 done:nil];
        _nameTextField.text = @"";
        [_nameTextField becomeFirstResponder];
        return ;
    }

    NSLog(@"%@",NSHomeDirectory());
    if ([[CSLUser shareInstance] registerUser:_nameTextField.text password:_passwordTextField.text]) {
        NSDictionary * dict = @{@"name":_nameTextField.text,
                                @"password":_passwordTextField.text};
        NSNotificationCenter *nc =[NSNotificationCenter defaultCenter];
        
        //name 通知名字， object通知者 userinfo通知内容
        [nc postNotificationName:@"registerUserInfo" object:nil userInfo:dict];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [Auxiliary alertWithTitle:NSLocalizedString(@"failure", nil) message:NSLocalizedString(@"register failure", nil) button:1 done:nil];
    }
    
   
}
-(IBAction) cancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) check{
    NSString * name = _nameTextField.text;
    NSString * pwd = _passwordTextField.text;
    NSString * confirm = _confirmPasswordTextField.text;
    
    //验证用户名
    if (![Auxiliary validateUserName:name rule:nil]) {
        _nameTextField.text = @"";//清空内容
        [_nameTextField becomeFirstResponder];//重新获得焦点
        [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"username rule", nil) button:1 done:nil];
        return NO;
    }
    
    
    //如果密码和确认密码不对称
    if (![pwd isEqualToString:confirm]) {
        [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"confirm pwd", nil) button:1 done:nil];
        return NO;
    }

    
    //验证密码是否符合规则
    if (![Auxiliary validatePassword:pwd rule:nil]) {
        [_passwordTextField becomeFirstResponder];
        _passwordTextField.text = @"";
        _confirmPasswordTextField.text = @"";
        [Auxiliary alertWithTitle:NSLocalizedString(@"reminder", nil) message:NSLocalizedString(@"password rule", nil) button:1 done:nil];
        return NO;
    }
    return YES;
}

//隐藏键盘
-(void) keyboardHidden{
    [self.view endEditing:YES];
}

#pragma mark---------UITextFieldDelegate-------
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self keyboardHidden];//隐藏键盘
    return YES;
}


@end
