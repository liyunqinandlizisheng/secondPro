//
//  CCGetAppClass.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetAppClassDelegate <NSObject>

- (void)returnAppClass:(BOOL)bRet andArrAppClass:(NSArray *)appList;

@end

@interface CCGetAppClass : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetAppClassDelegate>            delegate;
@property (nonatomic, retain) NSMutableArray                        *m_ArrAppList;

- (void)getAppClass:(NSString *)appUrl;

@end
