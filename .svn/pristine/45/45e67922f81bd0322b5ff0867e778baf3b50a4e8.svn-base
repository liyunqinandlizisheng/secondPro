//
//  CustomHomeView.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/12.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CustomHomeView.h"
#import "CCHomeListData.h"
#import "CommonViewController.h"
#import "WebViewController.h"
#import "HomeViewController.h"
#import "AddOtherViewController.h"
#import "Const.h"

@implementation CustomHomeView

@synthesize downLabel,zhuImageView, m_ArrList, m_iTag;
@synthesize m_HomeListData;
@synthesize m_CommonViewCtrl;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithHomeListData:(CCHomeListData *)homeListData andArray:(NSMutableArray *)array andTag:(int)iTag andFrame:(CGRect)viewFrame
{
    if (self = [super init])
    {
        self.frame = viewFrame;
        
        self.m_HomeListData = homeListData;
        self.m_ArrList = array;
        m_iTag = iTag;
        
        downLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/3-15, 65, 60, 15)];
        downLabel.textAlignment = NSTextAlignmentCenter;
        downLabel.backgroundColor = [UIColor clearColor];
        downLabel.font = [UIFont systemFontOfSize:14];
        downLabel.text = homeListData.m_StrAppName;
        [self addSubview:downLabel];
        
        
        NSLog(@"f = %f", self.frame.size.width);
        zhuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/3-10, 8, 50, 50)];
        zhuImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:zhuImageView];//栏目的图片

    }
    
    return self;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (m_iTag-10000 == m_ArrList.count-1)
    {
        NSLog(@"name = %@", m_HomeListData.m_StrAppName);
        
        if ([m_HomeListData.m_StrAppName isEqualToString:@"+"])
        {
            AddOtherViewController *addOtherViewCtrl = [[AddOtherViewController alloc] init];
            [m_CommonViewCtrl.m_HomeViewCtrl.navigationController pushViewController:addOtherViewCtrl animated:YES];
            
            return;
        }
    }
    else
    {
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
}


@end
