//
//  MessageSecondViewController.h
//  MobileOffice
//
//  Created by Wenrui on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSetReadOrNotRead.h"

@interface MessageSecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CCSetReadOrNotReadDelegate>

- (instancetype)initWithArray:(NSArray *)muArrList;

@end
