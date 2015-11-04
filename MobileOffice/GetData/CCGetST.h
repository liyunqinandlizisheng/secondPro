//
//  CCGetST.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetStDelegate <NSObject>

- (void)returnSt:(BOOL)bRet andSt:(NSString *)strSt;

@end

@interface CCGetST : NSObject

@property (nonatomic, retain) NSMutableData                         *m_NetData;
@property (nonatomic, retain) NSURLConnection                       *m_UrlConnection;
@property (nonatomic, retain) id <CCGetStDelegate>                  delegate;

- (void)getSt:(NSString *)stStUrl andUrl:(NSString *)urlString;

@end
