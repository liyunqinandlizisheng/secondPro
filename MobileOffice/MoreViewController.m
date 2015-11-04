//
//  MoreViewController.m
//  MobileOffice
//
//  Created by Wenrui on 15/9/14.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MoreViewController.h"
#import "Const.h"
#import "MOTopView.h"
#import "UIColor+ColorHexString.h"
#import "SDImageCache.h"
#import "SetingCell.h"
#import "AboutUsVC.h"
#import "MyInfoVC.h"
#import "ToastView.h"
#import "MyErWeiMaVC.h"
#import "RootViewController.h"
#import "LoginVC.h"

@interface MoreViewController ()

@property (nonatomic, retain) UITableView   *m_MoreTable;
@property (nonatomic, retain) NSMutableArray       *m_ArrList;

@property (nonatomic,strong) NSArray *firstSectionArray;
@property (nonatomic,strong) NSArray *secondArray;
@property (nonatomic,strong) NSArray *thirdArray;
@property (nonatomic,strong) NSArray *firstImageArray;
@property (nonatomic,strong) NSArray *secondImageArray;
@property (nonatomic,strong) NSArray *thirdImageArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation MoreViewController

@synthesize m_MoreTable;
@synthesize m_ArrList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.titleLabel.text = @"更多";
    [self.view addSubview:topView];
    
    m_ArrList = [[NSMutableArray alloc] initWithCapacity:0];
    _imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _firstImageArray = [[NSArray alloc] initWithObjects:@"d_my_email", nil];
    _secondArray = [[NSArray alloc] initWithObjects:@"d_app_recomm",@"d_app_recomm", nil];
    _thirdArray = [[NSArray alloc] initWithObjects:@"d_clear_cache",@"d_about_us", nil];
    [_imageArray addObject:_firstImageArray];
    [_imageArray addObject:_secondArray];
    [_imageArray addObject:_thirdArray];
    
    _firstSectionArray = [[NSArray alloc] initWithObjects:@"我的消息", nil];
    _secondArray = [[NSArray alloc] initWithObjects:@"扫一扫",@"我的二维码", nil];
    _thirdArray = [[NSArray alloc] initWithObjects:@"清除缓存",@"关于我们", nil];
    [m_ArrList addObject:_firstSectionArray];
    [m_ArrList addObject:_secondArray];
    [m_ArrList addObject:_thirdArray];
    
    m_MoreTable = [[UITableView alloc] initWithFrame:CGRectMake(10.0, IOS6?44:64, SCREEN_WIDTH - 20, SCREEN_HEIGHT-(IOS6?44:64) - ViewBarHeight) style:UITableViewStyleGrouped];
    m_MoreTable.delegate = self;
    m_MoreTable.dataSource = self;
    m_MoreTable.showsVerticalScrollIndicator = NO;
    m_MoreTable.backgroundColor = [UIColor clearColor];
    m_MoreTable.separatorColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:m_MoreTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell)
    {
        cell = [[SetingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSArray *tempArray = [m_ArrList objectAtIndex:indexPath.section] ;
    NSArray *tmepimageArr = [_imageArray objectAtIndex:indexPath.section];
    [cell setCellView];
    [cell.leftImageView setImage:[UIImage imageNamed:tmepimageArr[indexPath.row]]];
    cell.nameLabel.text = [tempArray objectAtIndex:indexPath.row];
    if (indexPath.section == 2 && indexPath.row == 0) {
        //只计算SDImageCache 图片缓存
        NSNumber *sizeNumber = [NSNumber numberWithLongLong:[[SDImageCache sharedImageCache] getSize]];
        cell.rightLabel.text = [NSString stringWithFormat:@"%.2fM",[sizeNumber floatValue]/1024/1024];
        cell.rightLabel.hidden = NO;
    }else{
        cell.rightLabel.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return m_ArrList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tempArray = [m_ArrList objectAtIndex:section];
    return tempArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetingCell *cell = (SetingCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        // 我的信息
        MyInfoVC *vc = [[MyInfoVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            // 扫一扫
            RootViewController *root = [[RootViewController alloc] init];
            [self.navigationController pushViewController:root animated:YES];
        }else if (indexPath.row == 1){
            // 我的二维码
            MyErWeiMaVC *erVC = [[MyErWeiMaVC alloc] init];
            [self.navigationController pushViewController:erVC animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            //清除缓存
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            cell.rightLabel.text = @"0.00M";
            
            [[ToastView sharedInstance] showToast:@"清理完成"];
        }else if (indexPath.row == 1){
            // 关于我们
            AboutUsVC *vc = [[AboutUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 100.0f;
    }
    return 0.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 100)];
        UIButton *outButt = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width - 20, 40)];
        outButt.layer.cornerRadius = 8;
        outButt.backgroundColor = [UIColor colorWithHexString:@"036dd0"];
        [outButt setTitle:@"注销" forState:UIControlStateNormal];
        [outButt addTarget:self action:@selector(clickoutButt:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:outButt];
        return view;
    }
    return nil;
}
-(void)clickoutButt:(id)sender
{
    LoginVC *logvc = [[LoginVC alloc] init];
    [self presentViewController:logvc animated:YES completion:nil];
}
@end
