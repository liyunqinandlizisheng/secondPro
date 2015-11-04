//
//  CCGetFacebackList.h
//  MobileOffice
//
//  Created by liyunqin on 15/10/22.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCGetFacebackListDelegate <NSObject>

-(void)returnFaceback:(BOOL)bRet andArrMyinfoState:(NSString *)isOk;

@end

@interface CCGetFacebackList : NSObject
@property (nonatomic, retain) NSMutableData  *m_NetData;
@property (nonatomic, retain) NSURLConnection    *m_UrlConnection;
@property (nonatomic, retain) id <CCGetFacebackListDelegate>    delegate;
@property (nonatomic, retain) NSMutableArray    *m_ArrAppList;

- (void)getFacebackList:(NSString *)myinfoUrl;
@end
