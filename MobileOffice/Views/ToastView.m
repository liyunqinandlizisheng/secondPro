//
//  ToastView.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/20.
//  Copyright © 2015年 Wenrui. All rights reserved.
//

#import "ToastView.h"

@implementation ToastView

+ (id)sharedInstance
{
    static ToastView *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ToastView alloc] initWithFrame:CGRectMake(10,250,300,40)];
    });
    return sharedInstance;
}

-(void)hidToast
{
    [self removeFromSuperview];
}

- (void)showToast:(NSString*)tip
{
    _tipLable.text = tip;
    CGSize size = [tip sizeWithFont:[UIFont systemFontOfSize:14]];
    float width = size.width;
    if (width > 300) {
        width = 300;
    }
    else if (width<100)
    {
        width = 100;
    }
    _tipLable.frame = CGRectMake(0,0,width+20,30);
    self.frame = CGRectMake((320 - width)/2, 250, width + 20, 30);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [NSTimer scheduledTimerWithTimeInterval:1.5f
                                     target:self
                                   selector:@selector(hidToast)
                                   userInfo:nil
                                    repeats:NO];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tipLable.backgroundColor = [UIColor blackColor];
        _tipLable.layer.opacity = 0.8;
        _tipLable.layer.masksToBounds = YES;
        _tipLable.textAlignment = NSTextAlignmentCenter;
        _tipLable.font = [UIFont systemFontOfSize:14];
        _tipLable.textColor = [UIColor whiteColor];
        _tipLable.layer.cornerRadius = 8.0;
        _tipLable.numberOfLines = 0;
        [self addSubview:_tipLable];
    }
    return self;
}
@end
