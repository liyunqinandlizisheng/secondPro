//
//  MyInfoVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MyInfoVC.h"
#import "Const.h"
#import "UIColor+ColorHexString.h"
#import "MOTopView.h"
#import "CCGetCookie.h"
#import "CCGetMyinfoList.h"
#import "CCMyinfoData.h"
#import "MyInfoCell.h"
#import "ToastView.h"
#import "MyErWeiMaVC.h"

@interface MyInfoVC () <UITableViewDataSource,UITableViewDelegate,CCGetCookieDelegate,CCGetMyinfoListDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *nameArray;
@end

@implementation MyInfoVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *strSessionNameKey = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_NAME_KEY];
    if (strSessionNameKey && [strSessionNameKey length] > 0)
    {
        CCGetMyinfoList *getMyinfo = [[CCGetMyinfoList alloc] init];
        getMyinfo.delegate = self;
        [getMyinfo getMyinfoList:MYINFO];
    }
    else
    {
        CCGetCookie *getCookie = [[CCGetCookie alloc] init];
        getCookie.delegate = self;
        [getCookie getCookie:@"admin" andPassWord:@"admin"];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _nameArray = [[NSMutableArray alloc] initWithObjects:@"姓       名",@"邮       箱",@"座       机",@"手       机",@"部       门", nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.titleLabel.text = @"个人信息";
    [self.view addSubview:topView];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y + topView.frame.size.height, self.view.bounds.size.width,self.view.bounds.size.height - topView.frame.origin.y - topView.frame.size.height  - ViewBarHeight) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView.separatorColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.view addSubview:_myTableView];
    
    //tableView headView
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 120)];
    view.backgroundColor = [UIColor colorWithHexString:@"00b2f2"];
    UIImageView *touxiangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
    touxiangImageView.center = CGPointMake(view.center.x, view.center.y - 5);
    touxiangImageView.image = [UIImage imageNamed:@"ic_action_message"];
    [view addSubview:touxiangImageView];
    
    _adminLabel = [[UILabel alloc] initWithFrame:CGRectMake(touxiangImageView.frame.origin.x , touxiangImageView.frame.origin.y + touxiangImageView.frame.size.height , touxiangImageView.frame.size.width, 25)];
    _adminLabel.textAlignment = NSTextAlignmentCenter;
    _adminLabel.textColor = [UIColor whiteColor];
    _adminLabel.font = [UIFont systemFontOfSize:16];
    _adminLabel.text = @"aaa";
    [view addSubview:_adminLabel];
    
    UIButton *erweiMaBut = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60 , 5, 32, 32)];
    [erweiMaBut setImage:[UIImage imageNamed:@"two_dimension_code"] forState:UIControlStateNormal];
    [erweiMaBut addTarget:self action:@selector(clickErWeiMaBut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:erweiMaBut];
    
    _myTableView.tableHeaderView = view;
}
-(void)clickErWeiMaBut:(id)sender
{
    MyErWeiMaVC *erweimaVC = [[MyErWeiMaVC alloc] init];
    [self.navigationController pushViewController:erweimaVC animated:YES];
    NSLog(@"go to my erweima vc");
}
- (void)returnCookie:(BOOL)bRet
{
    if (!bRet) {
        return;
    }
    
    CCGetMyinfoList *getMyinfo = [[CCGetMyinfoList alloc] init];
    getMyinfo.delegate = self;
    [getMyinfo getMyinfoList:MYINFO];
    
}
#pragma   mark  CCGetMyinfoListDelegate
-(void)returnMyinfoList:(BOOL)bRet andArrMyinfoList:(NSArray *)list
{
    if (!bRet)
    {
        return;
    }
    if (list.count != 0) {
        CCMyinfoData *myinfoData = list[0];
        [_dataArray addObject:myinfoData.userName];
        [_dataArray addObject:myinfoData.email];
        [_dataArray addObject:myinfoData.tel];
        [_dataArray addObject:myinfoData.mobileTel];
        [_dataArray addObject:myinfoData.deptNameStr];
        [_adminLabel setText:myinfoData.userCode];
    }
    [_myTableView reloadData];
}

- (void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 1) {
            UIPasteboard *paste = [UIPasteboard generalPasteboard];
            paste.string = [_dataArray objectAtIndex:1];
            
            [[ToastView sharedInstance] showToast:@"成功复制到粘贴板"];
        }
    }else if (alertView.tag == 1002){
        
    }
}
#pragma mark uitableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 50.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if ( cell == nil) {
        cell = [[MyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    if (_dataArray.count != 0) {
        [cell setCellView];
        cell.leftLabel.text = [_nameArray objectAtIndex:indexPath.row];
        cell.contentLabel.text = [_dataArray objectAtIndex:indexPath.row];

        if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    return cell;
}
-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"select %d row",indexPath.row);
    switch (indexPath.row) {
        case 0:
            NSLog(@"二维码");
            break;
        case 1:{
            NSLog(@"邮箱");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:_dataArray[1] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"复制", nil];
            alertView.tag = 1001;
            [alertView show];
        }
            break;
        case 2:
        {
            NSString *telStr = [NSString stringWithFormat:@"telprompt:%@",_dataArray[2]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
            
            break;
        case 3:
        {
            NSString *telStr = [NSString stringWithFormat:@"telprompt:%@",_dataArray[3]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
        }
            break;
            
        default:
            break;
    }
}
@end
