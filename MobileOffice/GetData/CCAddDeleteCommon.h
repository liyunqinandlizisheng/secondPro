//
//  CCAddDeleteCommon.h
//  MobileOffice
//
//  Created by Wenrui on 15/10/15.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCAddDeleteCommonDelegate <NSObject>

- (void)returnAddDelete:(BOOL)bRet;

@end

@interface CCAddDeleteCommon : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCAddDeleteCommonDelegate>        delegate;
@property (nonatomic, retain) NSMutableArray                        *m_ArrAppList;

- (void)addDeleteCommon:(NSString *)strUrl;

@end
