//
//  CCGetCookie.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/17.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGetTgt.h"
#import "CCGetST.h"

@protocol CCGetCookieDelegate <NSObject>

- (void)returnCookie:(BOOL)bRet;

@end


@interface CCGetCookie : NSObject <CCGetTgtDelegate, CCGetStDelegate>

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetCookieDelegate>              delegate;
@property (nonatomic, retain) NSMutableArray                        *m_ArrAppList;

- (void)getCookie:(NSString *)userName andPassWord:(NSString *)passWord;

@end
