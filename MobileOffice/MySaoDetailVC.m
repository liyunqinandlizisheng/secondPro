//
//  MySaoDetailVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MySaoDetailVC.h"
#import "MOTopView.h"
#import "Const.h"

@interface MySaoDetailVC () <UIWebViewDelegate>

@end

@implementation MySaoDetailVC
-(void)clickBackBut
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"扫描结果";
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    _myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y + topView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - topView.frame.origin.y - topView.frame.size.height)];
    _myWebView.delegate = self;
    if (self.urlStr.length != 0) {
        [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }else{
        [_myWebView loadHTMLString:self.htmlStr baseURL:nil];
    }
    [self.view addSubview:_myWebView];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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

@end
