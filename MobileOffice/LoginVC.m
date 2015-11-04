//
//  LoginVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "LoginVC.h"
#import "MOButton.h"
#import "UIColor+ColorHexString.h"
#import "ToastView.h"
#import "SetIpView.h"
#import "CCGetCookie.h"
#import "Const.h"
#import "ActivityView.h"

@interface LoginVC () <UITextFieldDelegate,CCGetCookieDelegate>

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MOButton *ipoButton = [[MOButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 30, 68, 50)];
    [ipoButton.topImageView setImage:[UIImage imageNamed:@"config_ip_press.png"]];
    ipoButton.nameLabel.text = @"ip设置";
    [ipoButton addTarget:self action:@selector(clickIpButt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ipoButton];
    
    UIImageView *logImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 96.5)/2, 100, 96.5, 37.5)];
    logImageView.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logImageView];
    
    //登陆
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, logImageView.frame.origin.y + logImageView.frame.size.height + 40, self.view.bounds.size.width - 40, 104)];
    bgImageView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    bgImageView.image = [UIImage imageNamed:@""];
    [self.view addSubview:bgImageView];
    bgImageView.userInteractionEnabled = YES;
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 42, 42)];
    userImageView.image = [UIImage imageNamed:@"login_user_hightlighted"];
    [bgImageView addSubview:userImageView];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, userImageView.frame.size.height + userImageView.frame.origin.y + 5, bgImageView.frame.size.width - 20, 0.5)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [bgImageView addSubview:lineImageView];
    
    userTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(userImageView.frame.origin.x + userImageView.frame.size.width + 5, userImageView.frame.origin.y + 5, 150, 42)];
    userTextFeild.borderStyle = UITextBorderStyleNone;
    userTextFeild.placeholder = @"请输入用户名";
    userTextFeild.delegate = self;
    userTextFeild.font = [UIFont systemFontOfSize: 14];
    userTextFeild.textColor = [UIColor blackColor];
    userTextFeild.text = [[NSUserDefaults standardUserDefaults] valueForKey:SAVED_UserName];
    [bgImageView addSubview:userTextFeild];
    
    UIImageView *passwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, lineImageView.frame.origin.y + lineImageView.frame.size.height + 3, 42, 42)];
    passwordImageView.image = [UIImage imageNamed:@"login_key_hightlighted"];
    [bgImageView addSubview:passwordImageView];
    
    passwordTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(passwordImageView.frame.origin.x + passwordImageView.frame.size.width + 5, passwordImageView.frame.origin.y + 5, 150, 42)];
    passwordTextFeild.font = [UIFont systemFontOfSize: 14];
    passwordTextFeild.secureTextEntry = YES;
    passwordTextFeild.delegate = self;
    passwordTextFeild.borderStyle = UITextBorderStyleNone;
    passwordTextFeild.placeholder = @"请输入密码";
    passwordTextFeild.textColor = [UIColor blackColor];
    [bgImageView addSubview:passwordTextFeild];
    
    UISwitch *saveSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(bgImageView.frame.size.width - 60, passwordTextFeild.frame.origin.y , 40, 42)];
    [saveSwitch addTarget:self action:@selector(saveSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    NSNumber *number = [[NSUserDefaults standardUserDefaults] valueForKey:ISSavePassword];
    saveSwitch.on = [number boolValue];
    [bgImageView addSubview:saveSwitch];
    
    if ([number boolValue]) {
        passwordTextFeild.text = [[NSUserDefaults standardUserDefaults] valueForKey:SAVED_Passwrod];
    }
    
    UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(bgImageView.frame.origin.x, bgImageView.frame.origin.y + bgImageView.frame.size.height + 20, self.view.bounds.size.width - bgImageView.frame.origin.x*2, 40)];
    logButton.layer.cornerRadius = 10;
    logButton.backgroundColor = [UIColor colorWithHexString:@"0e3ca2"];
    [logButton setTitle:@"登录" forState:UIControlStateNormal];
    [logButton addTarget:self action:@selector(clickLogButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logButton];
    
    UILabel *boomttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 20)];
    boomttonLabel.textAlignment = NSTextAlignmentCenter;
    boomttonLabel.textColor = [UIColor blackColor];
    boomttonLabel.font = [UIFont systemFontOfSize:12];
    boomttonLabel.text = @"Copyright @ 2014-2015 Inc.All rights reserved";
    [self.view addSubview:boomttonLabel];

    UILabel *lastLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, boomttonLabel.frame.origin.y + boomttonLabel.frame.size.height , self.view.bounds.size.width, 20)];
    lastLabel.textAlignment = NSTextAlignmentCenter;
    lastLabel.textColor = [UIColor blackColor];
    lastLabel.font = [UIFont systemFontOfSize:12];
    lastLabel.text = @"中视广信公司 版权所有";
    [self.view addSubview:lastLabel];
}
-(void)clickIpButt:(UIButton *)button
{
   NSLog(@"clickpoButton");
    SetIpView *view = [[SetIpView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:view];
}
-(void)clickLogButton:(UIButton *)button
{
    NSLog(@"click 登陆 button");
    if (userTextFeild.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (passwordTextFeild.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    [userTextFeild resignFirstResponder];
    [passwordTextFeild resignFirstResponder];
    
    [[ActivityView shareInstance] showActivityView];
    //保存用户名
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVED_UserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVED_Passwrod];
    [[NSUserDefaults standardUserDefaults] setValue:userTextFeild.text forKey:SAVED_UserName];
    [[NSUserDefaults standardUserDefaults] setValue:passwordTextFeild.text forKey:SAVED_Passwrod];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    CCGetCookie *getCookie = [[CCGetCookie alloc] init];
    getCookie.delegate = self;
    [getCookie getCookie:userTextFeild.text andPassWord:passwordTextFeild.text];
}
-(void)saveSwitchValueChanged:(UISwitch *)swi
{
    NSLog(@"swi.value = %d",swi.on);
    if (swi.on) {
        swi.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:1] forKey:ISSavePassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[ToastView sharedInstance] showToast:@"已开启记住密码"];
        //need to handle save the password or not
        
    }else if(swi.on == NO){
        swi.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:0] forKey:ISSavePassword];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[ToastView sharedInstance] showToast:@"已关闭记住密码"];
        //need to handle save the password or not

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userTextFeild resignFirstResponder];
    [passwordTextFeild resignFirstResponder];
}
#pragma mark uitextfieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark CCGetCookieDelegate
- (void)returnCookie:(BOOL)bRet
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (!bRet) {
        return;
    }
    [[ActivityView shareInstance] hiddenActiveView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
