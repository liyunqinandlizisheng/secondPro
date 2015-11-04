//
//  AboutUsVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "AboutUsVC.h"
#import "Const.h"
#import "MOTopView.h"
#import "UIColor+ColorHexString.h"
#import "FacebackVC.h"

@interface AboutUsVC () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"系统通知",@"帮助与反馈", nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.titleLabel.text = @"关于我们";
    [self.view addSubview:topView];
    
    UIImageView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, topView.frame.origin.y + topView.frame.size.height + 30, 100, 28)];
    centerImageView.image = [UIImage imageNamed:@"load_logo"];
    [self.view addSubview:centerImageView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerImageView.frame.origin.y + centerImageView.frame.size.height, self.view.bounds.size.width, 40)];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.font = [UIFont systemFontOfSize:18];
    contentLabel.textColor = [UIColor colorWithHexString:@"939393"];
    contentLabel.text = @"移动门户1.1";
    [self.view addSubview:contentLabel];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, contentLabel.frame.origin.y + contentLabel.frame.size.height + 20, self.view.bounds.size.width, self.view.bounds.size.height - contentLabel.frame.size.height - contentLabel.frame.origin.y - ViewBarHeight) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:_myTableView];
}

-(void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark uitableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if ( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        FacebackVC *fackVC = [[FacebackVC alloc] init];
        [self.navigationController pushViewController:fackVC animated:YES];
    }
}
@end
