//
//  CCGetTgt.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetTgtDelegate <NSObject>

- (void)returnTgt:(BOOL)bRet andTgt:(NSString *)strTgt;

@end

@interface CCGetTgt : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetTgtDelegate>                 delegate;

- (void)getTgt:(NSString *)tgtUrl
   andUserName:(NSString *)userName
   andPassWord:(NSString *)passWord;

@end
