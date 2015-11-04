//
//  OtherSecondCell.m
//  MobileOffice
//
//  Created by Wenrui on 15/10/8.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "OtherSecondCell.h"

@implementation OtherSecondCell

@synthesize m_NameLbl;
@synthesize m_SelectedView;
@synthesize m_bIsSelected;
@synthesize m_Icon;

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
        m_bIsSelected = NO;
        
        m_Icon = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 15.0, 30.0, 30.0)];
        [self addSubview:m_Icon];
        
        m_NameLbl = [[UILabel alloc] initWithFrame:CGRectMake(70.0, 15.0, 150.0, 30.0)];
        m_NameLbl.backgroundColor = [UIColor clearColor];
        m_NameLbl.textColor = [UIColor blackColor];
        [self addSubview:m_NameLbl];
        
        m_SelectedView = [[UIImageView alloc] initWithFrame:CGRectMake(320.0, 20.0, 18.0, 18.0)];
        m_SelectedView.image = [UIImage imageNamed:@"checkbox_default"];
        [self addSubview:m_SelectedView];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
//    if (_mSelected)
//    {
//        if (((UITableView *)self.superview).isEditing)
//        {
//            self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
//        }
//        else
//        {
//            self.backgroundView.backgroundColor = [UIColor clearColor];
//        }
//        
//        self.textLabel.textColor = [UIColor darkTextColor];
//        [_mSelectedIndicator setImage:[UIImage imageNamed:@"icon_sel_mark.png"]];
//        self.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        self.backgroundView.backgroundColor = [UIColor clearColor];
//        self.textLabel.textColor = [UIColor grayColor];
//        [_mSelectedIndicator setImage:[UIImage imageNamed:@"icon_unsel_mark.png"]];
//        self.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    [UIView commitAnimations];
}

@end
