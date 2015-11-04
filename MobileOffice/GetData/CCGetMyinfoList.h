//
//  CCGetMyinfoList.h
//  MobileOffice
//
//  Created by liyunqin on 15/10/19.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetMyinfoListDelegate <NSObject>

-(void)returnMyinfoList:(BOOL)bRet andArrMyinfoList:(NSArray *)list;

@end

@interface CCGetMyinfoList : NSObject 
@property (nonatomic, retain) NSMutableData  *m_NetData;
@property (nonatomic, retain) NSURLConnection    *m_UrlConnection;
@property (nonatomic, retain) id <CCGetMyinfoListDelegate>    delegate;
@property (nonatomic, retain) NSMutableArray    *m_ArrAppList;

- (void)getMyinfoList:(NSString *)myinfoUrl;

@end
