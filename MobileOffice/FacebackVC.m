//
//  FacebackVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/22.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "FacebackVC.h"
#import "MOTopView.h"
#import "Const.h"
#import "UIColor+ColorHexString.h"
#import "CCGetCookie.h"
#import "CCGetFacebackList.h"
#import "ToastView.h"

@interface FacebackVC () <UITextViewDelegate,CCGetCookieDelegate,CCGetFacebackListDelegate>

@end

@implementation FacebackVC

-(void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickFinishButton:(UIButton *)sender
{
    if (myTextView.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，你还没有输入你的想法哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *strSessionNameKey = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    if (strSessionNameKey && [strSessionNameKey length] > 0)
    {
        CCGetFacebackList *face = [[CCGetFacebackList alloc] init];
        face.delegate = self;
        [face getFacebackList:[NSString stringWithFormat:@"%@%@",FaceBackUrl,myTextView.text]];
    }
    else
    {
        CCGetCookie *getCookie = [[CCGetCookie alloc] init];
        getCookie.delegate = self;
        [getCookie getCookie:@"admin" andPassWord:@"admin"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];

    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.titleLabel.text = @"意见反馈";
    topView.rightBtn.hidden = NO;
    [topView.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [topView.rightBtn addTarget:self action:@selector(clickFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height + 20, self.view.bounds.size.width, 120)];
    myTextView.backgroundColor = [UIColor whiteColor];
    myTextView.delegate = self;
    myTextView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:myTextView];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, myTextView.frame.origin.y, myTextView.frame.size.width, 40)];
    contentLabel.font = [UIFont systemFontOfSize:18];
    contentLabel.textColor = [UIColor colorWithHexString:@"eeeeee"];
    contentLabel.text = @"说说你的想法和建议吧";
    [self.view addSubview:contentLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark uitextView Delegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
  
    if (textView.text.length == 0) {
        contentLabel.hidden = NO;
    }else{
        contentLabel.hidden = YES;
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    contentLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        contentLabel.hidden = NO;
    }else{
        contentLabel.hidden = YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [myTextView resignFirstResponder];
}
#pragma mark CCGetCookieDelegate
-(void)returnCookie:(BOOL)bRet
{
    if (!bRet) {
        return;
    }
    
    CCGetFacebackList *face = [[CCGetFacebackList alloc] init];
    face.delegate = self;
    [face getFacebackList:[NSString stringWithFormat:@"%@%@",FaceBackUrl,myTextView.text]];
}
#pragma mark ccgetFacebackListDelegate
-(void)returnFaceback:(BOOL)bRet andArrMyinfoState:(NSString *)isOk
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"bRet = %d",bRet);
    if (!bRet) {
        return;
    }
        
    if ([isOk isEqualToString:@"OK"]) {
        [[ToastView sharedInstance] showToast:@"反馈发送成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
