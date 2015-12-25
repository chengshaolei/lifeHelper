//
//  CSLLoginViewController.m
//  登陆验证
//
//
//  Created by 成少雷 on 15-12-23.
//  Copyright (c) 2015年 CSL. All rights reserved.
//
//

#import "CSLLoginViewController.h"
#import "CSLCheckCodeView.h"
#import "CSLUser.h"
#import "CSLRegisterViewController.h"
#import "Auxiliary.h"

@interface CSLLoginViewController ()
-(void) registerUser:(id)sender;
-(void) login:(id)sender;
@end

@implementation CSLLoginViewController
{
    IBOutlet UITextField * _userNameTextField;
    IBOutlet UITextField * _passwordTextField;
    IBOutlet UITextField * _checkTextField;
    IBOutlet CSLCheckCodeView * _checkButton;
    BOOL isKeyboardShow;//键盘是否升起
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = NSLocalizedString(@"login", nil);
    //使用手势关闭键盘
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    //注册观察者
    //获得通知中心
    NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
    
    //注册观察者
    [nc addObserver:self selector:@selector(keyboardUp) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboarddisApper) name:UIKeyboardWillHideNotification object:nil];
    
    //注册用户的观察者
    [nc addObserver:self selector:@selector(registedUser:) name:@"registerUserInfo" object:nil];
    isKeyboardShow = NO;
}

//notification.userInfo就是发布的消息
-(void) registedUser:(NSNotification*)notification{
    NSDictionary * user = notification.userInfo;//得到发布消息
    _userNameTextField.text = user[@"name"];
    _passwordTextField.text = user[@"password"];
}

-(void) keyboardUp{
    if (!isKeyboardShow) {
        if (_checkTextField.isFirstResponder) {
            __weak CSLLoginViewController * weakSelf = self;
            [UIView animateWithDuration:1 animations:^{
                CGAffineTransform tf = weakSelf.view.transform;
                weakSelf.view.transform = CGAffineTransformTranslate(tf, 0, -100);
            } completion:^(BOOL finished) {
                isKeyboardShow = YES;
            }];
        }
    }
}

//键盘消失
-(void) keyboarddisApper{
    if (isKeyboardShow) {
        __weak CSLLoginViewController * weakSelf = self;
        [UIView animateWithDuration:1 animations:^{
            weakSelf.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            isKeyboardShow = NO;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _passwordTextField = nil;
    _userNameTextField = nil;
    _checkButton = nil;
    _checkTextField = nil;
}


//关闭键盘
-(void) keyboardHidden{
    //注销第一响应者
    [_checkTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
}

//凡是UIReposder子类都会自动执行touches的方法
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self keyboardHidden];
}

//注册
-(IBAction) registerUser:(id)sender{
    [self keyboardHidden];
    CSLRegisterViewController * registerController = [[CSLRegisterViewController alloc] initWithNibName:@" CSLRegisterViewController" bundle:nil];
    
    [self.navigationController pushViewController:registerController animated:YES];
}

//登录
-(IBAction) login:(id)sender{
    [self keyboardHidden];
    //验证码验证
    if ([_checkButton check:_checkTextField.text]==NO) {
        [Auxiliary alertWithTitle:NSLocalizedString(@"error", nil) message:NSLocalizedString(@"verification code error", nil) button:1 done:nil];
        return;
    }
    
    //通过单例验证用户信息
    CSLUser *user = [CSLUser shareInstance];
    ErrorType type = [user checkName:_userNameTextField.text password:_passwordTextField.text];
    if (type==SUCCESS) {
        //登录成功
        user.userName =_userNameTextField.text;
        user.password = _passwordTextField.text;
        user.isLogin = YES;
        if (_loginCallBack) {
            _loginCallBack(YES);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [Auxiliary alertWithTitle:NSLocalizedString(@"error", nil) message:NSLocalizedString(@"user name or password error", nil) button:1 done:nil];
        
    }
}

@end
