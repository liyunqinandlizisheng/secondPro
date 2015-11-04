//
//  HomeViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/14.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "HomeViewController.h"
#import "Const.h"
#import "YAScrollSegmentControl.h"
#import "CommonViewController.h"
#import "CCAppClassData.h"

@interface HomeViewController ()

@property (nonatomic, retain) NSArray           *m_ArrAppClass;
@property (nonatomic, retain) UIScrollView      *m_BottomScrollView;
@property (nonatomic, retain) NSMutableArray    *m_MuArrAppClassName;
@property (nonatomic, retain) NSMutableArray    *m_MuArrAppClass;
@property (nonatomic, assign) int               m_iX;

- (void)loadPage:(UIView *)view andIndex:(int)iIndex andAppClassName:(NSString *)appClassName;

@end

@implementation HomeViewController

@synthesize m_ArrAppClass;
@synthesize m_BottomScrollView;
@synthesize m_CommonViewCtrl;
@synthesize m_MuArrAppClassName;
@synthesize m_MuArrAppClass;
@synthesize m_iX;

- (id)init
{
    if (self = [super init])
    {
        CCGetCookie *getCookie = [[CCGetCookie alloc] init];
        getCookie.delegate = self;
        [getCookie getCookie:@"admin" andPassWord:@"admin"];
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (m_BottomScrollView)
    {
        NSString *appClassName = [m_MuArrAppClass objectAtIndex:m_iX];
        
        if (0 == m_iX)
        {
            appClassName = nil;
        }
        
        UIView *view = (UIView *)[m_BottomScrollView viewWithTag:1000+m_iX];
        
        [self loadPage:view andIndex:1000+m_iX andAppClassName:appClassName];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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


#pragma mark -
#pragma mark Private Class Function
- (void)loadPage:(UIView *)view andIndex:(int)iIndex andAppClassName:(NSString *)appClassName
{
    if (m_CommonViewCtrl)
    {
        [m_CommonViewCtrl.view removeFromSuperview];
        self.m_CommonViewCtrl = nil;
    }
    m_CommonViewCtrl = [[CommonViewController alloc] initWithTag:iIndex andAppClassName:appClassName];
    m_CommonViewCtrl.m_HomeViewCtrl = self;
    m_CommonViewCtrl.view.backgroundColor = [UIColor clearColor];
    [view addSubview:m_CommonViewCtrl.view];
}



#pragma mark -
#pragma mark YAScrollSegmentDelegate
- (void)didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"index = %ld", (long)index);
    
    m_iX = index;
    
    NSString *appClassName = [m_MuArrAppClass objectAtIndex:index];
    
    if (0 == index)
    {
        appClassName = nil;
    }
    
    UIView *view = (UIView *)[m_BottomScrollView viewWithTag:1000+index];
    
    [self loadPage:view andIndex:1000+index andAppClassName:appClassName];
    
    [m_BottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, m_BottomScrollView.contentOffset.y) animated:YES];
}


#pragma mark -
#pragma mark GetAppClassDelegate
- (void)returnAppClass:(BOOL)bRet andArrAppClass:(NSArray *)appList
{
    if (!bRet)
    {
        return;
    }
    
    self.m_ArrAppClass = appList;
    
    m_MuArrAppClassName = [[NSMutableArray alloc] initWithCapacity:0];
    m_MuArrAppClass = [[NSMutableArray alloc] initWithCapacity:0];
    
    [m_MuArrAppClassName addObject:@"常用"];
    [m_MuArrAppClass addObject:@"Common"];
    
    for (int i = 0; i < m_ArrAppClass.count; i ++)
    {
        CCAppClassData *appClassData = [m_ArrAppClass objectAtIndex:i];
        [m_MuArrAppClassName addObject:appClassData.m_StrAppClassName];
        [m_MuArrAppClass addObject:appClassData.m_StrAppClass];
    }
    
    YAScrollSegmentControl *segmentControl = [[YAScrollSegmentControl alloc] initWithFrame:CGRectMake(0, IOS6?0:20, SCREEN_WIDTH, 40)];
    segmentControl.buttons = m_MuArrAppClassName;
    segmentControl.delegate = self;
    segmentControl.tag = 9999;
    [segmentControl setBackgroundImage:[UIImage imageNamed:@"background"] forState:UIControlStateNormal];
    [segmentControl setBackgroundImage:[UIImage imageNamed:@"backgroundSelected"] forState:UIControlStateSelected];
    [segmentControl setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    segmentControl.gradientColor = [UIColor blueColor]; // Purposely set strange gradient color to demonstrate the effect
    [self.view addSubview:segmentControl];
    
    self.m_BottomScrollView = nil;
    m_BottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, IOS6?44:64, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS6?68.5:88.5))];
    m_BottomScrollView.backgroundColor = [UIColor clearColor];
    m_BottomScrollView.pagingEnabled = YES;
    m_BottomScrollView.delegate = self;
    [self.view addSubview:m_BottomScrollView];
    
    for (int index = 0; index < m_ArrAppClass.count+1; index ++)
    {
        UIView *nextView = [[UIView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0.0, SCREEN_WIDTH, m_BottomScrollView.frame.size.height)];
        nextView.tag = 1000+index;
        nextView.backgroundColor = [UIColor clearColor];
        [m_BottomScrollView addSubview:nextView];
    }
    
    
    m_BottomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*([m_ArrAppClass count]+1), SCREEN_HEIGHT-(IOS6?68.5:88.5));
    
    UIView *view = (UIView *)[m_BottomScrollView viewWithTag:1000+0];
    
    [self loadPage:view andIndex:1000+0 andAppClassName:nil];
}


#pragma mark -
#pragma mark GetCookieDelegate
- (void)returnCookie:(BOOL)bRet
{
    if (!bRet)
    {
        return;
    }

    CCGetAppClass *getAppClass = [[CCGetAppClass alloc] init];
    getAppClass.delegate = self;
    [getAppClass getAppClass:GETAPPCLASS];
}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSLog(@"x = %d", x);
    
    m_iX = x;
    
//    NSString *appClassName = [m_MuArrAppClass objectAtIndex:x];
//    
//    if (0 == x)
//    {
//        appClassName = nil;
//    }
//    
//    UIView *view = (UIView *)[m_BottomScrollView viewWithTag:1000+x];
//    
//    [self loadPage:view andIndex:1000+x andAppClassName:appClassName];
    
    YAScrollSegmentControl *segmentControl = (YAScrollSegmentControl *)[self.view viewWithTag:9999];
    UIButton *button = (UIButton *)[segmentControl.scrollView viewWithTag:x];
    
//    NSLog(@"tag = %d", button.tag);
    
    [segmentControl buttonSelect:button];
}




@end
