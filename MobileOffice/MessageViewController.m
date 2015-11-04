//
//  MessageViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/14.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MessageViewController.h"
#import "Const.h"
#import "CCMessageData.h"
#import "CustomMessageCell.h"
#import "UIImageView+WebCache.h"
#import "Library.h"
#import "WebViewController.h"
#import "MOTopView.h"
#import "MessageSecondViewController.h"

@interface MessageViewController ()

@property (nonatomic, retain) UITableView       *m_MessageTable;
@property (nonatomic, retain) NSArray           *m_ArrList;
@property (nonatomic, retain) NSTimer           *m_ReLoadTimer;
@property (nonatomic, retain) NSMutableArray    *m_ArrSystemNames;
@property (nonatomic, retain) NSMutableArray    *m_ArrWeiDu;

@end

@implementation MessageViewController

@synthesize m_MessageTable;
@synthesize m_ArrList;
@synthesize m_ReLoadTimer;
@synthesize m_ArrSystemNames;
@synthesize m_ArrWeiDu;

- (id)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadMessageData];
}


-(void)clickSetButton:(id)sender
{
    NSLog(@"点击设置button");
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"信息";
    topView.rightBtn.hidden = NO;
    [topView.rightBtn setImage:[UIImage imageNamed:@"settings_press"] forState:UIControlStateNormal];
    [topView.rightBtn addTarget:self action:@selector(clickSetButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)reloadMessageData
{
    NSString *strSessionNameKey = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    if (strSessionNameKey && [strSessionNameKey length] > 0)
    {
        CCGetMessageList *getMessageList = [[CCGetMessageList alloc] init];
        getMessageList.delegate = self;
        [getMessageList getMessageList:GetMessageList];
    }
    else
    {
        CCGetCookie *getCookie = [[CCGetCookie alloc] init];
        getCookie.delegate = self;
        [getCookie getCookie:@"admin" andPassWord:@"admin"];
    }
}


#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomMessageCell *cell = (CustomMessageCell *)[tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell)
    {
        cell = [[CustomMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *imagev = [[UIImageView alloc] init];
        imagev.backgroundColor = [UIColor colorWithRed:226/255.0 green:230/255.0 blue:232/255.0 alpha:1];
        cell.selectedBackgroundView = imagev;
    }
    
    CCMessageData *messageData = [m_ArrSystemNames objectAtIndex:indexPath.row];
    NSLog(@"messageData.m_StrSystemName = %@", messageData.m_StrSystemName);
    
    if (messageData.m_StrSystemIcon && [messageData.m_StrSystemIcon isKindOfClass:[NSString class]])
    {
        [cell.m_IconImgView setImageWithURL:[NSURL URLWithString: messageData.m_StrSystemIcon] placeholderImage:[UIImage imageNamed:@"loadingBottomImg.png"]];
    }
    
    NSMutableArray *muArrWeiDu = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < m_ArrWeiDu.count; i ++)
    {
        CCMessageData *messageDataWeidu = [m_ArrWeiDu objectAtIndex:i];
        NSLog(@"messageDataWeidu.SystemName = %@", messageDataWeidu.m_StrSystemName);
        
        if ([messageDataWeidu.m_StrSystemName isEqualToString:messageData.m_StrSystemName])
        {
            [muArrWeiDu addObject:messageDataWeidu];
        }
    }
    
    if (0 == muArrWeiDu.count)
    {
        cell.m_WeiduCountView.hidden = YES;
    }
    else
    {
        cell.m_WeiduCountView.hidden = NO;
        cell.m_WeiduCountLbl.text = [NSString stringWithFormat:@"%lu", (unsigned long)muArrWeiDu.count];
    }

    cell.m_TitleLbl.text = messageData.m_StrSystemName;
    cell.m_AutherLbl.text = messageData.m_StrMsgContent;
    cell.m_TimeLbl.text = messageData.m_StrSendTime;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count = %lu", (unsigned long)m_ArrSystemNames.count);
    
    return [m_ArrSystemNames count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Library *library = [[Library alloc] init];
    NSMutableArray *arrSaveList = [[NSMutableArray alloc] init];
    [library getMessageList:&arrSaveList];
    NSLog(@"count = %lu", (unsigned long)arrSaveList.count);
    
    CCMessageData *messageData = [m_ArrSystemNames objectAtIndex:indexPath.row];
    
    NSMutableArray *muArrList = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int j = 0; j < arrSaveList.count; j ++)
    {
        CCMessageData *messageDataSecond = [arrSaveList objectAtIndex:j];
        NSLog(@"messageDataSecond.m_StrSystemName = %@", messageDataSecond.m_StrSystemName);
        
        NSLog(@"flag = %@", messageDataSecond.m_StrReadFlag);
        
        if ([messageData.m_StrSystemName isEqualToString:messageDataSecond.m_StrSystemName])
        {
            [muArrList addObject:messageDataSecond];
        }
    }
    
    MessageSecondViewController *messageSecondViewCtrl = [[MessageSecondViewController alloc] initWithArray:muArrList];
    [self.navigationController pushViewController:messageSecondViewCtrl animated:NO];
    
//    WebViewController *webViewCtrl = [[WebViewController alloc] initWithUrl:messageData.m_StrMsgHref];
//    
//    [self presentViewController:webViewCtrl animated:YES completion:nil];
}


#pragma mark -
#pragma mark GetCookieDelegate
- (void)returnCookie:(BOOL)bRet
{
    if (!bRet)
    {
        return;
    }
    
    Library *library = [[Library alloc] init];
    NSMutableArray *arrSaveList = [[NSMutableArray alloc] init];
    [library getMessageList:&arrSaveList];
    NSLog(@"count = %lu", (unsigned long)arrSaveList.count);
    
    if (arrSaveList.count > 0)
    {
        self.m_ArrList = arrSaveList;
    }
    
    CCGetMessageList *getMessageList = [[CCGetMessageList alloc] init];
    getMessageList.delegate = self;
    [getMessageList getMessageList:GetMessageList];
}


#pragma mark -
#pragma mark GetMessageListDelegate
- (void)returnMessageList:(BOOL)bRet andArrMessageList:(NSArray *)messageList
{
//    m_ReLoadTimer = [NSTimer scheduledTimerWithTimeInterval:30.0
//                                                     target:self
//                                                   selector:@selector(reloadMessageData)
//                                                   userInfo:nil
//                                                    repeats:YES];
    NSLog(@"count = %lu", (unsigned long)messageList.count);
    
    if (!bRet)
    {
        return;
    }
    
    Library *library = [[Library alloc] init];
    NSMutableArray *arrSaveList = [[NSMutableArray alloc] init];
    [library getMessageList:&arrSaveList];
    NSLog(@"count = %lu", (unsigned long)arrSaveList.count);
    
    self.m_ArrWeiDu = nil;
    m_ArrWeiDu = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 获得未读的个数，并且把网络的数据存入数据库
    if (0 == arrSaveList.count)
    {
        for (int a = 0; a < messageList.count; a ++)
        {
            CCMessageData *messageData = [messageList objectAtIndex:a];
            
            Library *library = [[Library alloc] init];
            [library saveMessage:messageData];
            
            [m_ArrWeiDu addObject:messageData];
        }
    }
    else
    {

        for (int index = 0; index < messageList.count; index ++)
        {
            CCMessageData *messageData = [messageList objectAtIndex:index];
            
            for (int k = 0; k < arrSaveList.count; k ++)
            {
                CCMessageData *messageDataDB = [arrSaveList objectAtIndex:k];
                
                if ([messageData.m_StrPK isEqualToString:messageDataDB.m_StrPK])
                {
                    if ([messageDataDB.m_StrReadFlag isEqualToString:@"F"])
                    {
                        [m_ArrWeiDu addObject:messageDataDB];
                    }
                    
                    break;
                }
                
                if (k == arrSaveList.count-1)
                {
                    Library *library = [[Library alloc] init];
                    [library saveMessage:messageData];
                    
                    [m_ArrWeiDu addObject:messageData];
                }
            }
        }
    }
    
    NSLog(@"m_ArrWeiDu = %lu", (unsigned long)m_ArrWeiDu.count);
    
    
    NSMutableArray *arrSaveListFinal = [[NSMutableArray alloc] init];
    [library getMessageList:&arrSaveListFinal];
    NSLog(@"count = %lu", (unsigned long)arrSaveListFinal.count);
    // 获得所有组的列表，比较OA系统等等
    self.m_ArrSystemNames = nil;
    m_ArrSystemNames = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < arrSaveListFinal.count; i ++)
    {
        CCMessageData *messageData = [arrSaveListFinal objectAtIndex:i];
        NSLog(@"messageData.name = %@", messageData.m_StrSystemName);
        NSLog(@"messageData.time = %@", messageData.m_StrSendTime);
        
        if (0 == i)
        {
            [m_ArrSystemNames addObject:messageData];
        }
        
        for (int j = 0; j < m_ArrSystemNames.count; j ++)
        {
            CCMessageData *messageDataSecond = [m_ArrSystemNames objectAtIndex:j];
            
            NSLog(@"strSystemName = %@", messageDataSecond.m_StrSystemName);
            NSLog(@"messageDataSecond.time = %@", messageDataSecond.m_StrSendTime);
            
            if ([messageData.m_StrSystemName isEqualToString:messageDataSecond.m_StrSystemName])
            {
                NSDate *dateOne = [self timeChangeToDate:messageData.m_StrSendTime];
                NSDate *dateTwo = [self timeChangeToDate:messageDataSecond.m_StrSendTime];
                NSTimeInterval firstTimeInterval = [dateOne timeIntervalSince1970]*1;
                NSTimeInterval secondTimeInterval = [dateTwo timeIntervalSince1970]*1;
                if (firstTimeInterval - secondTimeInterval > 0)    //firstTimeInterval > secondTimeInterval
                {
                    [m_ArrSystemNames removeObject:messageDataSecond];
                    [m_ArrSystemNames addObject:messageData];
                    
                    break;
                }
                else if (firstTimeInterval - secondTimeInterval < 0 || firstTimeInterval - secondTimeInterval == 0)
                    //firstTimeInterval < secondTimeInterval or firstTimeInterval = secondTimeInterval
                {
                    break;
                }
            }
            
            if (j == m_ArrSystemNames.count-1)
            {
                [m_ArrSystemNames addObject:messageData];
            }
        }
    }
    
    
    m_MessageTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, IOS6?44:64, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS6?44:64)-49) style:UITableViewStylePlain];
    m_MessageTable.delegate = self;
    m_MessageTable.dataSource = self;
    //m_MessageTable.backgroundColor = [UIColor clearColor];
    //m_MessageTable.separatorColor = [UIColor clearColor];
    //m_MessageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_MessageTable];
}


- (NSDate *)timeChangeToDate:(NSString *)strTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:strTime];
    
    return date;
}

- (CCMessageData *)compareTwoTime:(CCMessageData *)messageDateOne andDateTwo:(CCMessageData *)messageDateTwo
{
    NSDate *dateOne = [self timeChangeToDate:messageDateOne.m_StrSendTime];
    NSDate *dateTwo = [self timeChangeToDate:messageDateTwo.m_StrSendTime];
    
    NSTimeInterval _fitstDate = [dateOne timeIntervalSince1970]*1;
    
    NSTimeInterval _secondDate = [dateTwo timeIntervalSince1970]*1;
    
    if (_fitstDate - _secondDate > 0)
    {
        return messageDateOne;
    }
    else if (_secondDate - _fitstDate > 0)
    {
        return messageDateTwo;
    }
    
    return nil;
}

@end
