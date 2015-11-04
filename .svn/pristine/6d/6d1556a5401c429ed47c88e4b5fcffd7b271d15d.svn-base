//
//  CustomTabBarController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/12.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CustomTabBarController.h"
#import "Const.h"
#import "MyNavigationController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MailViewController.h"
#import "MoreViewController.h"

@interface CustomTabBarController ()

@property (nonatomic, retain) UIImageView *m_HomeImgView;
@property (nonatomic, retain) UIImageView *m_MessageImgView;
@property (nonatomic, retain) UIImageView *m_MailImgView;
@property (nonatomic, retain) UIImageView *m_MoreImgView;

- (void)toggleTabBtn:(id)sender;

@end

@implementation CustomTabBarController

@synthesize m_HomeViewCtrl;
@synthesize m_MessageViewCtrl;
@synthesize m_MailViewCtrl;
@synthesize m_MoreViewCtrl;
@synthesize m_HomeImgView;
@synthesize m_MessageImgView;
@synthesize m_MailImgView;
@synthesize m_MoreImgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomTabBar];
    [self creatControllers];
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


- (void)createCustomTabBar
{
    UIImageView *bgImage=[[UIImageView alloc] init];
    bgImage.userInteractionEnabled = YES;
    bgImage.backgroundColor  = [UIColor whiteColor];
    bgImage.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    bgImage.tag=999;
    [self.view addSubview:bgImage];
    
    CGFloat space = (SCREEN_WIDTH - 3*30)/6;
    
    //新闻
    UIButton *xwbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    xwbtn.tag=200;
    [xwbtn addTarget:self action:@selector(toggleTabBtn:) forControlEvents:UIControlEventTouchUpInside];
    xwbtn.backgroundColor = [UIColor clearColor];
    xwbtn.frame=CGRectMake(0, 0, SCREEN_WIDTH/3, 49);
    [bgImage addSubview:xwbtn];
    
    m_HomeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(space, 5, 49/2, 49/2)];
    m_HomeImgView.tag = 500;
    //    xwImage.highlighted = YES;
    [xwbtn addSubview:m_HomeImgView];
    
    //首页
    UILabel *xwLabel=[[UILabel alloc]init];
    xwLabel.frame=CGRectMake(space, 30+3, 30,10);
    xwLabel.backgroundColor=[UIColor clearColor];
    xwLabel.text=@" 首页";
    xwLabel.tag=100;
    xwLabel.textColor=[UIColor colorWithRed:0.15f green:0.25f blue:0.60f alpha:1.00f];
    xwLabel.textAlignment=NSTextAlignmentLeft;
    xwLabel.font=[UIFont systemFontOfSize:10];
    [xwbtn addSubview:xwLabel];
    
    
    
    //时间链
    UIButton *sjlBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sjlBtn.backgroundColor = [UIColor clearColor];
    sjlBtn.tag=201;
    [sjlBtn addTarget:self action:@selector(toggleTabBtn:) forControlEvents:UIControlEventTouchUpInside];
    sjlBtn.frame=CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 49);
    [bgImage addSubview:sjlBtn];
    
    m_MessageImgView = [[UIImageView alloc]initWithFrame:CGRectMake(space, 5, 49/2, 49/2)];
    m_MessageImgView.tag = 501;
    [sjlBtn addSubview:m_MessageImgView];
    
    UILabel * sjlLabel=[[UILabel alloc]init];
    sjlLabel.frame=CGRectMake(space-3, 30+3, 30,10);
    sjlLabel.backgroundColor=[UIColor clearColor];
    sjlLabel.textColor = [UIColor lightGrayColor];
    sjlLabel.text=@"  信息";
    sjlLabel.tag=100+1;
    sjlLabel.textAlignment=NSTextAlignmentLeft;
    sjlLabel.font=[UIFont systemFontOfSize:10];
    [sjlBtn addSubview:sjlLabel];
    
//    //邮件
//    UIButton * tvBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    tvBtn.tag=202;
//    tvBtn.backgroundColor = [UIColor clearColor];
//    [tvBtn addTarget:self action:@selector(toggleTabBtn:) forControlEvents:UIControlEventTouchUpInside];
//    tvBtn.frame=CGRectMake(SCREEN_WIDTH/4*2, 0, SCREEN_WIDTH/4, 49);
//    [bgImage addSubview:tvBtn];
//    
//    m_MailImgView = [[UIImageView alloc]initWithFrame:CGRectMake(space, 5, 49/2, 49/2)];
//    m_MailImgView.tag = 502;
//    [tvBtn addSubview:m_MailImgView];
//    
//    UILabel * tvLabel=[[UILabel alloc]init];
//    tvLabel.frame=CGRectMake(space+2, 30+3, 30,10);
//    tvLabel.backgroundColor=[UIColor clearColor];
//    tvLabel.textColor = [UIColor lightGrayColor];
//    tvLabel.text=@"邮件";
//    tvLabel.tag=100+2;
//    tvLabel.textAlignment=NSTextAlignmentLeft;
//    tvLabel.font=[UIFont systemFontOfSize:10];
//    [tvBtn addSubview:tvLabel];
    
    //更多
    UIButton * tdsBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tdsBtn.tag=203;
    tdsBtn.backgroundColor = [UIColor clearColor];
    [tdsBtn addTarget:self action:@selector(toggleTabBtn:) forControlEvents:UIControlEventTouchUpInside];
    tdsBtn.frame=CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 49);
    [bgImage addSubview:tdsBtn];
    
    m_MoreImgView = [[UIImageView alloc]initWithFrame:CGRectMake(space, 5, 49/2, 49/2)];
    m_MoreImgView.tag = 503;
    [tdsBtn addSubview:m_MoreImgView];
    
    UILabel * tdsLabel=[[UILabel alloc]init];
    tdsLabel.frame=CGRectMake(space-3, 30+3,30,10);
    tdsLabel.backgroundColor=[UIColor clearColor];
    tdsLabel.textColor = [UIColor lightGrayColor];
    tdsLabel.text=@"更多";
    tdsLabel.tag=100+3;
    tdsLabel.textAlignment=NSTextAlignmentCenter;
    tdsLabel.font=[UIFont systemFontOfSize:10];
    [tdsBtn addSubview:tdsLabel];
    
    m_HomeImgView.image = [UIImage imageNamed:@"newsnormal.png"];
    m_HomeImgView.highlightedImage = [UIImage imageNamed:@"newsselect.png"];
    
    m_MessageImgView.image = [UIImage imageNamed:@"timelinenormal.png"];
    m_MessageImgView.highlightedImage = [UIImage imageNamed:@"timelineselect.png"];
    
//    m_MailImgView.image = [UIImage imageNamed:@"TVnormal.png"];
//    m_MailImgView.highlightedImage = [UIImage imageNamed:@"TVselect.png"];
    
    m_MoreImgView.image = [UIImage imageNamed:@"tingdianshinormal.png"];
    m_MoreImgView.highlightedImage = [UIImage imageNamed:@"tingdianshiselect.png"];
    
    m_HomeImgView.highlighted = YES;
    
}


- (void)creatControllers
{
//    m_CommonViewCtrl=[[CommonViewController alloc]init];
//    MyNavigationController *CommonNavCtrl = [[MyNavigationController alloc]initWithRootViewController:m_CommonViewCtrl];
//    m_CommonViewCtrl.hidesBottomBarWhenPushed = YES;
//    CommonNavCtrl.navigationBarHidden = YES;
//    //  m_CommonViewCtrl.tabBarItem.image=[UIImage imageNamed:@"tabbar_news@2x.png"];
//    //m_CommonViewCtrl.view.backgroundColor=[UIColor redColor];
    
    m_MessageViewCtrl = [[MessageViewController alloc] init];
    MyNavigationController *messageNavCtrl = [[MyNavigationController alloc]initWithRootViewController:m_MessageViewCtrl];
    messageNavCtrl.navigationBarHidden = YES;
    m_MessageViewCtrl.hidesBottomBarWhenPushed = YES;
    // m_TimeLineViewCtrl.tabBarItem.image = [UIImage imageNamed:@"tabbar_subject@2x.png"];
    //m_TimeLineViewCtrl.view.backgroundColor = [UIColor yellowColor];
    
    //初始化容器vc(电视页面)
    m_HomeViewCtrl = [[HomeViewController alloc]init];
    // m_TVViewCtrl.tabBarItem.image=[UIImage imageNamed:@"tabbar_picture@2x.png"];
    MyNavigationController *homeNavCtrl = [[MyNavigationController alloc]initWithRootViewController:m_HomeViewCtrl];
    homeNavCtrl.navigationBarHidden = YES;
    m_HomeViewCtrl.hidesBottomBarWhenPushed = YES;
    
    //初始化听电视页面
    m_MailViewCtrl = [[MailViewController alloc]init];
    //m_ListenTVViewCtrl.tabBarItem.image = [UIImage imageNamed:@"tabbar_news@2x.png"];
    UINavigationController *mailNavCtrl = [[UINavigationController alloc]initWithRootViewController:m_MailViewCtrl];
    mailNavCtrl.navigationBarHidden = YES;
    m_MailViewCtrl.hidesBottomBarWhenPushed = YES;
    
    m_MoreViewCtrl = [[MoreViewController alloc]init];
    // m_TVViewCtrl.tabBarItem.image=[UIImage imageNamed:@"tabbar_picture@2x.png"];
    MyNavigationController *moreNavCtrl = [[MyNavigationController alloc]initWithRootViewController:m_MoreViewCtrl];
    moreNavCtrl.navigationBarHidden = YES;
    m_MoreViewCtrl.hidesBottomBarWhenPushed = YES;
    
    self.viewControllers = [NSArray arrayWithObjects:homeNavCtrl,messageNavCtrl,m_MailViewCtrl,moreNavCtrl, nil];
}


- (void)toggleTabBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (self.viewControllers)
    {
        self.selectedViewController = [self.viewControllers objectAtIndex:btn.tag-200];
    }
    
    UIImageView *bgView=(UIImageView*)[self.view viewWithTag:999];
    
    for (UIView *view in bgView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *button1 = (UIButton *)view;
            if (button1.tag == btn.tag)
            {
                for (UIView *subView in button1.subviews)
                {
                    if ([subView isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *image = (UIImageView *)subView;
                        image.highlighted = YES;
                    }
                }
            }
            else
            {
                for (UIView *subView in button1.subviews)
                {
                    if ([subView isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *image = (UIImageView *)subView;
                        image.highlighted = NO;
                    }
                }
            }
        }
    }
}

@end
