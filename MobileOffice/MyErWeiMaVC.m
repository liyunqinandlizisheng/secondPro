//
//  MyErWeiMaVC.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MyErWeiMaVC.h"
#import "MOTopView.h"
#import "Const.h"
#import "QRCodeGenerator.h"

@interface MyErWeiMaVC ()

@end

@implementation MyErWeiMaVC
-(void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    MOTopView *topView = [[MOTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, IOS6?44:64)];
    topView.backBtn.hidden = NO;
    [topView.backBtn addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    topView.titleLabel.text = @"我的二维码";
    [self.view addSubview:topView];
    
    _erWeiMaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, topView.frame.origin.y + topView.frame.size.height + 10, self.view.bounds.size.width - 10*2, self.view.bounds.size.width - 10*2)];
    [self.view addSubview:_erWeiMaImageView];
    
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _smallImageView.center = _erWeiMaImageView.center;
    _smallImageView.image = [UIImage imageNamed:@"desk_logo"];
    [self.view addSubview:_smallImageView];
    
    _erWeiMaImageView.image = [QRCodeGenerator qrImageForString:[[NSUserDefaults standardUserDefaults] valueForKey:SAVED_UserName] imageSize:_erWeiMaImageView.frame.size.width];
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(_erWeiMaImageView.frame.origin.x + 5, _erWeiMaImageView.frame.origin.y + _erWeiMaImageView.frame.size.height + 10, _erWeiMaImageView.frame.size.width-10, 30)];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont systemFontOfSize:14];
    myLabel.textColor = [UIColor blackColor];
    myLabel.text = @"扫一扫上面的二维码图片,查看我的名片";
    [self.view addSubview:myLabel];
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

@end
