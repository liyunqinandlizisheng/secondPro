//
//  CustomMessageSecondCell.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/20.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CustomMessageSecondCell.h"
#import "Const.h"

@implementation CustomMessageSecondCell

@synthesize m_TitleLbl;
@synthesize m_AutherLbl;
@synthesize m_TimeLbl;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
//        m_IconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 50.0, 50.0)];
//        m_IconImgView.backgroundColor = [UIColor clearColor];
//        [self addSubview:m_IconImgView];
        
//        m_IconLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 75.0, 150.0, 20.0)];
//        m_IconLbl.backgroundColor = [UIColor clearColor];
//        [self addSubview:m_IconLbl];
        
        m_TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 200.0, 30.0)];
        m_TitleLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:m_TitleLbl];
        
        m_AutherLbl = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 50.0, 300.0, 20.0)];
        m_AutherLbl.backgroundColor = [UIColor clearColor];
        m_AutherLbl.textColor = [UIColor grayColor];
        [self addSubview:m_AutherLbl];
        
        m_TimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80+5-20, 10.0, 100.0, 20.0)];
        m_TimeLbl.font = [UIFont systemFontOfSize:14.0f];
        m_TimeLbl.backgroundColor = [UIColor clearColor];
        m_TimeLbl.textColor = [UIColor grayColor];
        [self addSubview:m_TimeLbl];
    }
    
    return self;
}

@end
