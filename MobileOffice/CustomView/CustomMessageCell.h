//
//  CustomMessageCell.h
//  MobileOffice
//
//  Created by Wenrui on 15/10/14.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMessageCell : UITableViewCell

@property (nonatomic, retain) UIImageView   *m_IconImgView;
@property (nonatomic, retain) UILabel       *m_IconLbl;
@property (nonatomic, retain) UILabel       *m_TitleLbl;
@property (nonatomic, retain) UILabel       *m_AutherLbl;
@property (nonatomic, retain) UILabel       *m_TimeLbl;
@property (nonatomic, retain) UIView        *m_WeiduCountView;
@property (nonatomic, retain) UILabel       *m_WeiduCountLbl;

@end
