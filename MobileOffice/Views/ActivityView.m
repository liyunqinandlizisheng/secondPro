//
//  ActivityView.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/23.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "ActivityView.h"

@implementation ActivityView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImageView.backgroundColor = [UIColor blackColor];
        _bgImageView.alpha = 0.4;
        [self addSubview:_bgImageView];
        
        _centerBGImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        _centerBGImageView.center = CGPointMake(frame.size.width / 2, frame.size.height/2);
        _centerBGImageView.backgroundColor = [UIColor blackColor];
        _centerBGImageView.alpha = 0.6;
        _centerBGImageView.layer.cornerRadius = 8;
        [self addSubview:_centerBGImageView];
        
        _cirleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _cirleImageView.center = CGPointMake(frame.size.width /2, frame.size.height/2 - 15);
        _cirleImageView.image = [UIImage imageNamed:@"img_common_progressdialog"];
        [self addSubview:_cirleImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_centerBGImageView.frame.origin.x , _cirleImageView.frame.origin.y + _cirleImageView.frame.size.height + 10, 120, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"正在登录验证";
        [self addSubview:_titleLabel];
        
    }
    return self;
}
+(ActivityView *)shareInstance{
    static ActivityView *actionView;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        actionView = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    });
    return actionView;
}
-(void)showActivityView
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self startCirle];
}
-(void)hiddenActiveView
{
    [self removeFromSuperview];
}
-(void)startCirle
{
    CABasicAnimation* rotate =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    rotate.removedOnCompletion = FALSE;
    rotate.fillMode = kCAFillModeForwards;
    
    //Do a series of 5 quarter turns for a total of a 1.25 turns
    //(2PI is a full turn, so pi/2 is a quarter turn)
    [rotate setToValue: [NSNumber numberWithFloat: M_PI / 2]];
    rotate.repeatCount = 1100;
    
    rotate.duration = 0.25;
    //            rotate.beginTime = start;
    rotate.cumulative = TRUE;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [_cirleImageView.layer addAnimation:rotate forKey:@"rotateAnimation"];
}
@end
