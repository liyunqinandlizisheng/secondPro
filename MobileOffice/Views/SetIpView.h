//
//  SetIpView.h
//  MobileOffice
//
//  Created by liyunqin on 15/10/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetIpView : UIView <UITextFieldDelegate>
{
    UITextField *userTextFeild;
    UITextField *casTextFeild;
}
@property (nonatomic,strong) UIView *bgView;
@end
