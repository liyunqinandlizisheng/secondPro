//
//  CCGetMessageList.h
//  MobileOffice
//
//  Created by Wenrui on 15/10/13.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetMessageListDelegate <NSObject>

- (void)returnMessageList:(BOOL)bRet andArrMessageList:(NSArray *)messageList;

@end

@interface CCGetMessageList : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetMessageListDelegate>         delegate;
@property (nonatomic, retain) NSMutableArray                        *m_ArrAppList;

- (void)getMessageList:(NSString *)messageUrl;

@end
