//
//  CommonViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"
#import "Const.h"
#import "MMGridView.h"
#import "MMGridViewDefaultCell.h"
#import "CCHomeListData.h"
#import "UIImageView+WebCache.h"
#import "CCAppClassData.h"
#import "HomeViewController.h"
#import "Library.h"
#import "CustomHomeView.h"

#define WIDTH  65
#define HIGHT  105

#define TAGH  10

#define BTNWIDTH  WIDTH - TAGH
#define BTNHIGHT  HIGHT - TAGH

@interface CommonViewController ()

@property (nonatomic, retain) NSMutableArray    *m_ArrList;
@property (nonatomic, assign) int               m_iTag;
@property (nonatomic, retain) MMGridView        *m_GridView;
@property (nonatomic, retain) NSString          *m_StrAppClassName;
@property (nonatomic, retain) UIImageView       *m_HeadImgView;
@property (nonatomic, assign) BOOL              m_bTransform;
@property (nonatomic, retain) UIView            *m_BackView;
@property (nonatomic, retain) UIScrollView      *m_BottomScrollView;


@end

@implementation CommonViewController

@synthesize m_iTag;
@synthesize m_GridView;
@synthesize m_ArrList;
@synthesize m_StrAppClassName;
@synthesize m_HomeViewCtrl;
@synthesize m_HeadImgView;
@synthesize m_bTransform;
@synthesize m_BackView;
@synthesize m_BottomScrollView;

- (instancetype)initWithTag:(int)iTag
            andAppClassName:(NSString *)appClassName
{
    if (self = [super init])
    {
        m_iTag = iTag;
        self.m_StrAppClassName = appClassName;
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"dfdfdffdf");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString *strSessionNameKey = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    if (strSessionNameKey && [strSessionNameKey length] > 0)
    {
        CCGetHomeList *getHomeList = [[CCGetHomeList alloc] init];
        getHomeList.delegate = self;
        [getHomeList getHomeList:GetHomeList];
    }
    else
    {
        CCGetCookie *getCookie = [[CCGetCookie alloc] init];
        getCookie.delegate = self;
        [getCookie getCookie:@"admin" andPassWord:@"admin"];
    }
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
#pragma mark GridViewDelegate
- (NSInteger)numberOfCellsInGridView:(MMGridView *)gridView
{
    return [m_ArrList count];
}


- (MMGridViewCell *)gridView:(MMGridView *)gridView cellAtIndex:(NSUInteger)index
{
    CCHomeListData *homeListData = [m_ArrList objectAtIndex:index];
    
    MMGridViewTDefauleCell *cell = [[MMGridViewTDefauleCell alloc] initWithHomeListData:homeListData];
    cell.m_CommonViewCtrl = self;
    
    if (homeListData.m_StrIcon && [homeListData.m_StrIcon isKindOfClass:[NSString class]])
    {
        [cell.zhuImageView setImageWithURL:[NSURL URLWithString: homeListData.m_StrIcon] placeholderImage:[UIImage imageNamed:@"loadingBottomImg.png"]];
    }
    
    
    //cell.downLabel.text = homeListData.m_StrAppName;
    
    return cell;
}


#pragma mark -
#pragma mark GetCookieDelegate
- (void)returnCookie:(BOOL)bRet
{
    if (!bRet)
    {
        return;
    }
    
    CCGetHomeList *getHomeList = [[CCGetHomeList alloc] init];
    getHomeList.delegate = self;
    [getHomeList getHomeList:GetHomeList];
}


#pragma mark -
#pragma mark GetHomeListDelegate
- (void)returnHome:(BOOL)bRet andArrHomeList:(NSMutableArray *)homeList
{    
    if (!bRet)
    {
        return;
    }
    
    NSMutableArray *muArrCurrentPageList = [[NSMutableArray alloc] initWithCapacity:0];
    
    if (1000 == m_iTag && !m_StrAppClassName)    // 常用
    {
        Library *library = [[Library alloc] init];
        NSMutableArray *arrSaveList = [[NSMutableArray alloc] init];
        [library getSaveList:&arrSaveList];
        NSLog(@"count = %lu", (unsigned long)arrSaveList.count);
        
        if (0 == arrSaveList.count)    // 网上下载的数据
        {
            for (int index = 0; index < homeList.count; index ++)
            {
                CCHomeListData *homeListData = [homeList objectAtIndex:index];
                
                //NSString *strMessagePush = homeListData.m_StrMessagePushFlag;
                //NSLog(@"push = %@", strMessagePush);
                
                NSLog(@"homeListData.m_StrDefaultApp = %@", homeListData.m_StrDefaultApp);
                
                if ([homeListData.m_StrDefaultApp isEqual:@"true"])
                {
                    [muArrCurrentPageList addObject:homeListData];
                    
                    Library *library = [[Library alloc] init];
                    [library save:homeListData];
                }
            }
        }
        else                            // 数据库中的数据
        {
            muArrCurrentPageList = arrSaveList;
        }

        
//        Library *library = [[Library alloc] init];
//        NSMutableArray *arrSaveList = [[NSMutableArray alloc] init];
//        [library getSaveList:&arrSaveList];
//        NSLog(@"count = %lu", (unsigned long)arrSaveList.count);
//        
//        muArrCurrentPageList = arrSaveList;
        
        CCHomeListData *homeListData = [[CCHomeListData alloc] init];
        homeListData.m_StrAppName = @"+";
        [muArrCurrentPageList addObject:homeListData];
        
    }
    else
    {
        for (int j = 0; j < [homeList count]; j ++)
        {
            CCHomeListData *homeListData = [homeList objectAtIndex:j];
            
//            NSLog(@"m_StrAppClassCode = %@", homeListData.m_StrAppClassCode);
//            NSLog(@"m_StrAppClassName = %@", m_StrAppClassName);
            
            if ([m_StrAppClassName isEqualToString:homeListData.m_StrAppClassCode])
            {
                [muArrCurrentPageList addObject:homeListData];
            }
        }
    }
    
    self.m_ArrList = muArrCurrentPageList;
    
    NSLog(@"count = %lu", (unsigned long)m_ArrList.count);
    
    if (1000 == m_iTag && !m_StrAppClassName)    // 常用
    {
        m_HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 151)];
        m_HeadImgView.image = [UIImage imageNamed:@"d_beijing.png"];
        [self.view addSubview:m_HeadImgView];
        
        self.m_BottomScrollView = nil;
//        m_BottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, IOS6?140:160, SCREEN_WIDTH, self.view.frame.size.height-(IOS6?(44):(64)))];
        m_BottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, IOS6?140:160, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS6?140:160)-49)];
        m_BottomScrollView.backgroundColor = [UIColor clearColor];
        m_BottomScrollView.pagingEnabled = YES;
        m_BottomScrollView.delegate = self;
        [self.view addSubview:m_BottomScrollView];
    }
    else
    {
        self.m_BottomScrollView = nil;
        m_BottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, self.view.frame.size.height-(IOS6?(44):(64)))];
        m_BottomScrollView.backgroundColor = [UIColor clearColor];
        m_BottomScrollView.pagingEnabled = YES;
        m_BottomScrollView.delegate = self;
        [self.view addSubview:m_BottomScrollView];
    }
    
    m_BackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(IOS6?(44):(64)))];
    m_BackView.backgroundColor = [UIColor clearColor];
    [m_BottomScrollView addSubview:m_BackView];
    
    int width = self.view.frame.size.width/3;
    
    float fTotalHeight = 0.0;
    for (int i = 0; i < [m_ArrList count]; i++)
    {
        CCHomeListData *homeListData = [m_ArrList objectAtIndex:i];
        
        int t = i/3;
        int d = fmod(i, 3);
        UIView *nView = [[UIView alloc] initWithFrame:CGRectMake(width * d + 5, HIGHT * t +10, self.view.frame.size.width/3-10, HIGHT)];
        nView.userInteractionEnabled = YES;
        nView.backgroundColor = [UIColor clearColor];
        CustomHomeView *homeView = [[CustomHomeView alloc] initWithHomeListData:homeListData andArray:m_ArrList andTag:i+10000 andFrame:CGRectMake(TAGH-10, TAGH, self.view.frame.size.width/3-10, BTNHIGHT)];
        homeView.m_CommonViewCtrl = self;
        if (homeListData.m_StrIcon && [homeListData.m_StrIcon isKindOfClass:[NSString class]])
        {
            [homeView.zhuImageView setImageWithURL:[NSURL URLWithString: homeListData.m_StrIcon] placeholderImage:[UIImage imageNamed:@"loadingBottomImg.png"]];
        }
        homeView.backgroundColor = [UIColor clearColor];
        [nView addSubview:homeView];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.tag = i;
        [deleteBtn setFrame:CGRectMake(0, 0, 20, 20)];
        [deleteBtn setImage:[UIImage imageNamed:@"deleteTag.png"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(toggleDeleteBtn:event:) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setHidden:YES];
        [nView addSubview:deleteBtn];
        
        [m_BackView addSubview:nView];
    }
    
    
    m_BottomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 30);
    
    if (1000 == m_iTag && !m_StrAppClassName)
    {
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTap:)];
        [self.view addGestureRecognizer:lpgr];
        
        UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toggleDoubleTap:)];
        [tapGestureTel2 setNumberOfTapsRequired:2];
        [tapGestureTel2 setNumberOfTouchesRequired:1];
        [self.view addGestureRecognizer:tapGestureTel2];
    }

}


- (void)toggleDoubleTap:(UIGestureRecognizer *)gr
{
    if(m_bTransform==NO)
        return;
    
    for (UIView *view in m_BackView.subviews)
    {
        view.userInteractionEnabled = NO;
        for (UIView *v in view.subviews)
        {
            if ([v isMemberOfClass:[UIImageView class]])
                [v setHidden:YES];
        }
    }
    m_bTransform = NO;
    [self EndWobble];
}


- (void)toggleDeleteBtn:(id)sender event:(id)event
{
    UIButton *btn = (UIButton *)sender;
    int index = (int)btn.tag;
    
    if (index == m_ArrList.count-1)
    {
        return;
    }
    
    NSLog(@"index = %d", index);
    
    CCHomeListData *homeListData = [m_ArrList objectAtIndex:index];
    
    NSArray *views = m_BackView.subviews;
    __block CGRect newframe;
    for (int i = index; i < [m_ArrList count]; i++)
    {
        UIButton *obj = [views objectAtIndex:i];
        __block CGRect nextframe = obj.frame;
        if (i == index)
        {
            [obj removeFromSuperview];
        }
        else
        {
            for (UIView *v in obj.subviews)
            {
                if ([v isMemberOfClass:[UIButton class]])
                {
                    v.tag = i - 1;
                    break;
                }
            }
            [UIView animateWithDuration:0.6 animations:^
             {
                 obj.frame = newframe;
             } completion:^(BOOL finished)
             {
             }];
        }
        newframe = nextframe;
    }
    
    NSLog(@"homeListData.m_StrPK = %@", homeListData.m_StrPK);

    [m_ArrList removeObjectAtIndex:index];
    
    Library *library = [[Library alloc] init];
    [library removeSaveInfo:homeListData.m_StrPK];
    
    CCAddDeleteCommon *addDeleteCommon = [[CCAddDeleteCommon alloc] init];
    addDeleteCommon.delegate = self;
    [addDeleteCommon addDeleteCommon:[NSString stringWithFormat:@"%@%@", ADDDELETECOMMON, FALSE_KEY]];
}


- (void)longPressTap:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        if (m_bTransform)
            return;
        
        for (UIView *view in m_BackView.subviews)
        {
            view.userInteractionEnabled = YES;
            for (UIView *v in view.subviews)
            {
                if ([v isMemberOfClass:[UIButton class]])
                    [v setHidden:NO];
            }
        }
        m_bTransform = YES;
        [self BeginWobble];
    }
}


-(void)BeginWobble
{
    for (UIView *view in m_BackView.subviews)
    {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             view.transform=CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  view.transform=CGAffineTransformMakeRotation(0.05);
              } completion:^(BOOL finished) {}];
         }];
    }
}

-(void)EndWobble
{
    for (UIView *view in m_BackView.subviews)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             view.transform=CGAffineTransformIdentity;
             view.userInteractionEnabled = YES;
             for (UIView *v in view.subviews)
             {
                 if ([v isMemberOfClass:[UIButton class]])
                     [v setHidden:YES];
             }
         } completion:^(BOOL finished) {}];
    }
}


- (void)returnAddDelete:(BOOL)bRet
{
    
}


@end
