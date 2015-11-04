//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

//#define K_DEFAULT_LABEL_HEIGHT  30
//#define K_DEFAULT_LABEL_INSET   5
//
//#import "MMGridViewDefaultCell.h"
//
//@implementation MMGridViewDefaultCell
//
//@synthesize textLabel;
//@synthesize textLabelBackgroundView;
//@synthesize backgroundView;
//
//- (void)dealloc
//{
//    [textLabel release];
//    [textLabelBackgroundView release];
//    [backgroundView release];
//    [super dealloc];
//}
//
//
//- (id)initWithFrame:(CGRect)frame 
//{
//    if ((self = [super initWithFrame:frame])) {
//        // Background view
//        self.backgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
//        self.backgroundView.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:self.backgroundView];
//        
//        // Label
//        self.textLabelBackgroundView = [[[UIView alloc] initWithFrame:CGRectNull] autorelease];
//        self.textLabelBackgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//        
//        self.textLabel = [[[UILabel alloc] initWithFrame:CGRectNull] autorelease];
//        self.textLabel.textAlignment = UITextLayoutDirectionRight;
//        self.textLabel.backgroundColor = [UIColor clearColor];
//        self.textLabel.textColor = [UIColor whiteColor];
//        self.textLabel.font = [UIFont systemFontOfSize:12];
//        
//        [self.textLabelBackgroundView addSubview:self.textLabel];
//        [self addSubview:self.textLabelBackgroundView];
//    }
//    
//    return self;
//}
//
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    labelHeight = K_DEFAULT_LABEL_HEIGHT;
//    labelInset = K_DEFAULT_LABEL_INSET;
//    
//    // Background view
//    self.backgroundView.frame = self.bounds;
//    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    // Layout label
//    self.textLabelBackgroundView.frame = CGRectMake(0, 
//                                                    self.bounds.size.height - labelHeight - labelInset, 
//                                                    self.bounds.size.width, 
//                                                    labelHeight);
//    self.textLabelBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    // Layout label background
//    CGRect f = CGRectMake(0, 
//                          0, 
//                          self.textLabel.superview.bounds.size.width,
//                          self.textLabel.superview.bounds.size.height);
//    self.textLabel.frame = CGRectInset(f, labelInset, 0);
//    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//}
//
//@end

#import "MMGridViewDefaultCell.h"
#import "CCHomeListData.h"
#import "Const.h"
#import "CommonViewController.h"
#import "WebViewController.h"
#import "HomeViewController.h"
#import "AddOtherViewController.h"

@implementation MMGridViewTDefauleCell

@synthesize downLabel,m_DeleteBtn,zhuImageView;
@synthesize m_HomeListData;
@synthesize m_bIsCollect;
@synthesize m_CommonViewCtrl;
@synthesize m_bIsShowDeleteBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}


- (id)initWithHomeListData:(CCHomeListData *)homeListData
{
    if (self = [super init])
    {
        self.m_HomeListData = homeListData;
        
        int a = 1;
        int b = 0;
//        if (!iPhone)
//        {
//            a = 2;
//            b = 20;
//        }
        
        downLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,65,zhuImageView.frame.size.width+100,15)];
        downLabel.textAlignment = NSTextAlignmentCenter;
        downLabel.backgroundColor = [UIColor clearColor];
        downLabel.font = [UIFont systemFontOfSize:14];
        downLabel.text = homeListData.m_StrAppName;
        [self addSubview:downLabel];
        
        zhuImageView = [[UIImageView alloc ]initWithFrame:CGRectMake(10+b, 8, 81*a, 50*a)];
        zhuImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:zhuImageView];//栏目的图片
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8+b,6,81*a+4,50*a+4)];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.layer.cornerRadius = 2;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 1;
        //[self addSubview:imageView];//显示边框的view
        
        m_DeleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(81*a-21+b, 6,33, 33)];
        m_DeleteBtn.contentMode = UIViewContentModeRight;
        m_DeleteBtn.backgroundColor = [UIColor yellowColor];
        [m_DeleteBtn addTarget:self action:@selector(toggleDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_DeleteBtn];
        m_DeleteBtn.hidden = YES;
        
        //显示这个栏目名称的 lable 已经被废除了
        downLabel = [[UILabel alloc ]initWithFrame:CGRectMake(8,65,zhuImageView.frame.size.width,15)];
        downLabel.textAlignment = NSTextAlignmentCenter;
        downLabel.backgroundColor = [UIColor clearColor];
        downLabel.font = [UIFont systemFontOfSize:14];
        //[self addSubview:downLabel];
        
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSingleTap:)];
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
        
        UITapGestureRecognizer* doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleDoubleTap:)];
        doubleRecognizer.numberOfTapsRequired = 2; // 双击
        //关键语句，给self.view添加一个手势监测；
        [self addGestureRecognizer:doubleRecognizer];
        
        [singleRecognizer requireGestureRecognizerToFail:doubleRecognizer];
        
        
//        if (![self isCollect])
//        {
//            imageView.backgroundColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:0.3];//黑一点
//            [zuobutton setImage:[UIImage imageNamed:@"lanmu_add.png"] forState:UIControlStateNormal];
//            downLabel.textColor = [UIColor blueColor];
//
//        }
//        else
//        {
//            imageView.backgroundColor = [UIColor clearColor];
//            [zuobutton setImage:[UIImage imageNamed:@"lanmu_get.png"] forState:UIControlStateNormal];
//            downLabel.textColor = [UIColor blackColor];
//
//        }

        
//        DLog(@"self.frame %@", NSStringFromCGRect(self.frame));
    }
    
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"name = %@", m_HomeListData.m_StrAppName);
    
    if ([m_HomeListData.m_StrAppName isEqualToString:@"+"])
    {
        AddOtherViewController *addOtherViewCtrl = [[AddOtherViewController alloc] init];
        [m_CommonViewCtrl.m_HomeViewCtrl.navigationController pushViewController:addOtherViewCtrl animated:YES];
        
        return;
    }
    
    if ([m_HomeListData.m_StrAppKind isEqualToString:@"HTML5"])
    {
        WebViewController *webViewCtrl = [[WebViewController alloc] initWithUrl:m_HomeListData.m_StrAppUrl];
        
        [m_CommonViewCtrl.m_HomeViewCtrl presentViewController:webViewCtrl animated:YES completion:nil];
        //[m_CommonViewCtrl.m_HomeViewCtrl.navigationController pushViewController:webViewCtrl animated:YES];
    }
    else if ([m_HomeListData.m_StrAppKind isEqualToString:@"APP"])
    {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"myapp://com.angeldevil.eventbusdemo"];//myapp为目标App的key
        if([[UIApplication sharedApplication] canOpenURL:myURL_APP_A])
        {
            
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
    }
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    Library *library = [[Library alloc] init];
//    
//    if (m_bIsCollect)
//    {
//        //取消订阅名栏
//        [MobileAppTracker trackEvent:m_ColumnData.m_ColumnName label:@"电视_栏目" category:@"取消订阅"];
//        if (iPhone)
//        {
//            [library removeColumn:m_ColumnData.m_ColumnID];
//        }
//        else
//        {
//            [library ipad_removeColumn:m_ColumnData.m_ColumnID];
//        }
//        imageView.backgroundColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:0.3];//黑一点
//        [zuobutton setImage:[UIImage imageNamed:@"lanmu_add.png"] forState:UIControlStateNormal];
//        downLabel.textColor = [UIColor blueColor];
//    }
//    else
//    {
//        //订阅
//        [MobileAppTracker trackEvent:m_ColumnData.m_ColumnName label:@"电视_栏目" category:@"订阅"];
//        if (iPhone)
//        {
//            [library insertColumn:m_ColumnData];
//        }
//        else
//        {
//            [library ipad_insertColumn:m_ColumnData];
//        }
//        imageView.backgroundColor = [UIColor clearColor];
//        [zuobutton setImage:[UIImage imageNamed:@"lanmu_get.png"] forState:UIControlStateNormal];
//        downLabel.textColor = [UIColor blackColor];
//    }
//    
//    m_bIsCollect = !m_bIsCollect;
//}
//
//- (BOOL)isCollect
//{
//    DLog(@"在这里判断这篇文章是否收藏");
//    
//    m_bIsCollect = NO;
//    
//    NSMutableArray *dataSource = [[NSMutableArray alloc]init];
//    
//    Library *library = [[Library alloc] init];
//    if (iPhone)
//    {
//        [library getColumnItem:&dataSource];
//    }
//    else
//    {
//        [library ipad_getColumnItem:&dataSource];
//    }
//    
//    for (CCColumnData *data in dataSource)
//    {
//        if([data.m_ColumnID isEqualToString:self.m_ColumnData.m_ColumnID])
//        {
//            m_bIsCollect = YES;
//        }
//    }
//
//    return m_bIsCollect;
//}
//
//
//
////点勾的方法
//-(void)chickbutton:(id)sender
//{
//    Library *library = [[Library alloc] init];
//    
//    if (m_bIsCollect)
//    {
//        //取消订阅名栏
//        [MobileAppTracker trackEvent:m_ColumnData.m_ColumnName label:@"电视_栏目" category:@"取消订阅"];
//        if (iPhone)
//        {
//            [library removeColumn:m_ColumnData.m_ColumnID];
//        }
//        else
//        {
//            [library ipad_removeColumn:m_ColumnData.m_ColumnID];
//        }
//        imageView.backgroundColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:0.3];//黑一点
//        [zuobutton setImage:[UIImage imageNamed:@"lanmu_add.png"] forState:UIControlStateNormal];
//        downLabel.textColor = [UIColor blueColor];
//    }
//    else
//    {
//        //订阅
//        [MobileAppTracker trackEvent:m_ColumnData.m_ColumnName label:@"电视_栏目" category:@"栏目订阅"];
//        if (iPhone)
//        {
//            [library insertColumn:m_ColumnData];
//        }
//        else
//        {
//            [library ipad_insertColumn:m_ColumnData];
//        }
//        
//        imageView.backgroundColor = [UIColor clearColor];
//        [zuobutton setImage:[UIImage imageNamed:@"lanmu_get.png"] forState:UIControlStateNormal];
//        downLabel.textColor = [UIColor blackColor];
//    }
//    
//    m_bIsCollect = !m_bIsCollect;
//}


- (void)toggleDeleteBtn:(id)sender event:(id)event
{
    
}


- (void)toggleSingleTap:(id)sender
{
    
}


- (void)toggleDoubleTap:(id)sender
{
    if (m_bIsShowDeleteBtn)
    {
        m_DeleteBtn.hidden = YES;
    }
    else
    {
        m_DeleteBtn.hidden = NO;
    }
    
    m_bIsShowDeleteBtn = !m_bIsShowDeleteBtn;
}


- (void)layoutSubviews
{
    
}

@end
