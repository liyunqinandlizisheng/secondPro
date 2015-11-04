//
//  CommonViewController.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMGridView.h"
#import "CCGetHomeList.h"
#import "CCGetCookie.h"
#import "CCAddDeleteCommon.h"

@class CCAppClassData;
@class HomeViewController;
@interface CommonViewController : UIViewController <MMGridViewDelegate, MMGridViewDataSource, CCGetHomeListDelegate, CCGetCookieDelegate, UIScrollViewDelegate, CCAddDeleteCommonDelegate>

@property (nonatomic, retain) HomeViewController *m_HomeViewCtrl;

- (instancetype)initWithTag:(int)iTag andAppClassName:(NSString *)appClassName;

@end
