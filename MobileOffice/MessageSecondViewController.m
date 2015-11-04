//
//  MessageSecondViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MessageSecondViewController.h"
#import "Const.h"
#import "CustomMessageSecondCell.h"
#import "CCMessageData.h"
#import "MOTopView.h"
#import "Library.h"
#import "MessageDetailViewController.h"

@interface MessageSecondViewController ()

@property (nonatomic, retain) UITableView       *m_MessageTable;
@property (nonatomic, retain) NSArray           *m_MuArrList;

@end

@implementation MessageSecondViewController

@synthesize m_MessageTable;
@synthesize m_MuArrList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"消息";
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.rightBtn.hidden = NO;
    [topView.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topView.rightBtn setTitle:@"全部删除" forState:UIControlStateNormal];
    topView.rightBtn.frame = CGRectMake(self.view.bounds.size.width - 80, 20, 75, 42);
    [topView.rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    m_MessageTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, IOS6?44:64, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS6?44:64)-49) style:UITableViewStylePlain];
    m_MessageTable.delegate = self;
    m_MessageTable.dataSource = self;
    //m_MessageTable.backgroundColor = [UIColor clearColor];
    //m_MessageTable.separatorColor = [UIColor clearColor];
    //m_MessageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_MessageTable];
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


- (instancetype)initWithArray:(NSArray *)muArrList
{
    if (self = [super init])
    {
        self.m_MuArrList = [muArrList sortedArrayUsingComparator:^NSComparisonResult(CCMessageData *p1, CCMessageData *p2){
            return [p2.m_StrSendTime compare:p1.m_StrSendTime];
        }];
        
        NSLog(@"m_MuArrList = %lu", (unsigned long)m_MuArrList.count);
    }
    
    return self;
}


#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomMessageSecondCell *cell = (CustomMessageSecondCell *)[tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell)
    {
        cell = [[CustomMessageSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *imagev = [[UIImageView alloc] init];
        imagev.backgroundColor = [UIColor colorWithRed:226/255.0 green:230/255.0 blue:232/255.0 alpha:1];
        cell.selectedBackgroundView = imagev;
    }
    
    CCMessageData *messageData = [m_MuArrList objectAtIndex:indexPath.row];
    
    if ([messageData.m_StrReadFlag isEqualToString:@"F"])
    {
        cell.m_TitleLbl.textColor = [UIColor blackColor];
    }
    else
    {
        cell.m_TitleLbl.textColor = [UIColor grayColor];
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
    return m_MuArrList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCMessageData *messageData = [m_MuArrList objectAtIndex:indexPath.row];
    
    if ([messageData.m_StrReadFlag isEqualToString:@"F"])
    {        
        Library *library = [[Library alloc] init];
        [library saveMessage:messageData];
        
        CCSetReadOrNotRead *setReadOrNot = [[CCSetReadOrNotRead alloc] init];
        setReadOrNot.delegate = self;
        [setReadOrNot setIsReadStatus:SETREADORNOT andPK:messageData.m_StrPK];
    }
    
    MessageDetailViewController *messageDetailViewCtrl = [[MessageDetailViewController alloc] init];
    messageDetailViewCtrl.messageData = messageData;
    [self.navigationController pushViewController:messageDetailViewCtrl animated:NO];
}


- (void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)clickRightButton:(UIButton *)sender
{
    NSLog(@"全部删除");
    
//    for (int i = 0; i < m_MuArrList.count; i ++)
//    {
//        CCMessageData *messageData = [m_MuArrList objectAtIndex:i];
//        
//        Library *library = [[Library alloc] init];
//        [library removeMessageInfo:messageData.m_StrPK];
//    }
//    
//    [m_MessageTable reloadData];
}

@end
