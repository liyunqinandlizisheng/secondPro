//
//  Library.h
//  CCTV
//
//  Created by wen rui on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define DATABASE_NAME       @"Library.sqlite3"

#define IPHONE_DEVICE_KEY   @"iPhoneDeviceKey"

#define CREATE_VIDEOCOLLECT_TABLE "CREATE TABLE collectTable (pkID VARCHAR PRIMARY KEY not null, appName VARCHAR, appCode VARCHAR, company VARCHAR, comPerson VARCHAR, comTel VARCHAR, icon VARCHAR, appKind VARCHAR, appClassCode VARCHAR, appSort VARCHAR, urlGetnum VARCHAR, messagePushFlag VARCHAR, flag VARCHAR, defaultApp VARCHAR, appPackage VARCHAR, appActivity VARCHAR, appEntry VARCHAR, appUrl VARCHAR)"

#define CREATE_MESSAGELIST_TABLE "CREATE TABLE messageTable (pkID VARCHAR PRIMARY KEY not null, msgContent VARCHAR, msgHref VARCHAR, msgLevel VARCHAR, msgTitle VARCHAR, readFlag VARCHAR, readTime VARCHAR, receiverDeptCodes VARCHAR, receiverUserCodes VARCHAR, sendPerson VARCHAR, sendTime VARCHAR, systemCode VARCHAR, systemIcon VARCHAR, systemName VARCHAR, usercode VARCHAR)"

@class CCHomeListData;
@class CCMessageData;

@interface Library : NSObject
{
    sqlite3 *m_Database;
}

// Manage Home
- (BOOL)save:(CCHomeListData *)homeListData;
- (BOOL)getSaveList:(NSMutableArray **)saveList;
- (BOOL)removeSaveInfo:(NSString *)pid;
- (BOOL)removeAllSaveInfo;

// Manage Message
- (BOOL)saveMessage:(CCMessageData *)messageData;
- (BOOL)getMessageList:(NSMutableArray **)messageList;
- (BOOL)removeMessageInfo:(NSString *)pkID;
- (BOOL)removeAllMessageInfo;
- (BOOL)updateMessage:(CCMessageData *)messageData
          andReadFlag:(NSString *)strReadFlag;

@end
