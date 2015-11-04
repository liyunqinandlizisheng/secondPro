//
//  AddOtherSecondViewController.h
//  MobileOffice
//
//  Created by Wenrui on 15/10/8.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGetHomeList.h"
#import "CCAddDeleteCommon.h"

@class CCAppClassData;
@interface AddOtherSecondViewController : UIViewController <CCGetHomeListDelegate, UITableViewDataSource, UITableViewDelegate, CCAddDeleteCommonDelegate>

@property (nonatomic, retain) CCAppClassData    *m_AppClassData;
@property (nonatomic, retain) UITableView       *m_AddOtherSecondTable;
@property (nonatomic, retain) NSArray           *m_ArrList;

- (id)initWithAppClassData:(CCAppClassData *)appClassData;

@end
