//
//  MessageDetailViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MOTopView.h"
#import "Const.h"
#import "UIColor+ColorHexString.h"
#import "WebViewController.h"
#import "UILabel+StringFrame.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)clickRightBut:(UIButton *)button
{
    NSLog(@"click 删除 button");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"消息详情";
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.rightBtn.hidden = NO;
    [topView.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [topView.rightBtn addTarget:self action:@selector(clickRightBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, topView.frame.origin.y + topView.frame.size.height + 10, self.view.bounds.size.width - 20 , self.view.bounds.size.height - topView.frame.origin.y - topView.frame.size.height - 20 - ViewBarHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [self.view addSubview:bgView];
    
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, bgView.frame.origin.y + 5, bgView.frame.size.width, bgView.frame.size.height - 60)];
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_myScrollView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, _myScrollView.frame.size.width - 10, 50)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.messageData.m_StrMsgContent;
    [_myScrollView addSubview:titleLabel];
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, titleLabel.frame.origin.y + titleLabel.frame.size.height, _myScrollView.frame.size.width - 10, 30)];
    dayLabel.font = [UIFont systemFontOfSize:18];
    dayLabel.textColor = [UIColor blackColor];
    dayLabel.text = [NSString stringWithFormat:@" %@     %@",self.messageData.m_StrSendTime,self.messageData.m_StrSystemName];
    [_myScrollView addSubview:dayLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = [UIFont systemFontOfSize:18];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    contentLabel.text = self.messageData.m_StrMsgContent;
    [_myScrollView addSubview:contentLabel];
    
    CGSize size = [contentLabel boundingRectWithSize:CGSizeMake(_myScrollView.frame.size.width - 10, 0)];
    contentLabel.frame = CGRectMake(5, dayLabel.frame.origin.y + dayLabel.frame.size.height, _myScrollView.frame.size.width - 10, size.height);
    
    _myScrollView.contentSize = CGSizeMake(bgView.frame.size.width, size.height + titleLabel.frame.size.height + dayLabel.frame.size.height + 10);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, bgView.frame.size.height - 50, bgView.frame.size.width - 10, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"b9b9b9"];
    [bgView addSubview:line];
    
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(5, line.frame.origin.y + line.frame.size.height, 100, 40)];
    [detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    detailButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [detailButton setTitle:@"查看详情..." forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:detailButton];
    
}
-(void)clickDetailButton:(UIButton *)button
{
    NSLog(@"click detail button");
    
    WebViewController *webVC = [[WebViewController alloc] initWithUrl:self.messageData.m_StrMsgHref];
    [self.navigationController pushViewController:webVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
