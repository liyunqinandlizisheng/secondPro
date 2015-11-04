//
//  MailViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/14.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MailViewController.h"
#import "Const.h"
#import "MOTopView.h"

@interface MailViewController ()

@property (nonatomic, retain) UITableView   *m_MailTable;
@property (nonatomic, retain) NSArray       *m_ArrList;

@end

@implementation MailViewController

@synthesize m_MailTable;
@synthesize m_ArrList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"更多";
    [self.view addSubview:topView];
    
    m_ArrList = [[NSArray alloc] initWithObjects:@"新闻", @"通知", @"审批拦", @"未料1", @"未料2", @"未料3", @"未料4", @"未料5", nil];
    
    m_MailTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0, IOS6?44:64, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS6?44:64)) style:UITableViewStylePlain];
    m_MailTable.delegate = self;
    m_MailTable.dataSource = self;
    m_MailTable.backgroundColor = [UIColor clearColor];
    m_MailTable.separatorColor = [UIColor clearColor];
    m_MailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_MailTable];
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


#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        cell.backgroundColor = [UIColor clearColor];
        
        UIImageView *imagev = [[UIImageView alloc] init];
        imagev.backgroundColor = [UIColor colorWithRed:226/255.0 green:230/255.0 blue:232/255.0 alpha:1];
        cell.selectedBackgroundView = imagev;
    }
    cell.textLabel.text = [m_ArrList objectAtIndex:indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_ArrList count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
