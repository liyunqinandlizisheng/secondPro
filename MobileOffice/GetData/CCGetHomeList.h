//
//  CCGetHomeList.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetHomeListDelegate <NSObject>

- (void)returnHome:(BOOL)bRet andArrHomeList:(NSMutableArray *)homeList;

@end

@interface CCGetHomeList : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetHomeListDelegate>            delegate;
@property (nonatomic, retain) NSMutableArray                        *m_ArrHomeList;
@property (nonatomic, assign) BOOL                                  m_bIsExistData;

- (void)getHomeList:(NSString *)homeUrl;

@end

