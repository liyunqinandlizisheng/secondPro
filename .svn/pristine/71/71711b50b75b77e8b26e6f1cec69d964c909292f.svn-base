//
//  CustomOtherCell.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/19.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "CustomOtherCell.h"

@implementation CustomOtherCell

@synthesize m_IconImgView;
@synthesize m_TitleLbl;

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
        m_IconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 50.0, 50.0)];
        m_IconImgView.backgroundColor = [UIColor clearColor];
        [self addSubview:m_IconImgView];
        
        m_TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 10.0, 100.0, 30.0)];
        m_TitleLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:m_TitleLbl];
        
    }
    
    return self;
}


@end
