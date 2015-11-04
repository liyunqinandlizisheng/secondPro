//
//  SetingCell.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/16.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "SetingCell.h"

#define kLeftImageViewTag 3000
#define kNameLabelTag 3001
#define kRightLabelTag 3002

@implementation SetingCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCellView
{
    _leftImageView = (UIImageView *) [self viewWithTag:kLeftImageViewTag];
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 45)];
        _leftImageView.tag = kLeftImageViewTag;
        [self addSubview:_leftImageView];
    }
    
    _nameLabel = (UILabel *) [self viewWithTag:kNameLabelTag];
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.frame.origin.x + _leftImageView.frame.size.width + 10, 10, 120, 40)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.tag = kNameLabelTag;
        _nameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_nameLabel];
    }
    
    _rightLabel = (UILabel *) [self viewWithTag:kRightLabelTag];
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 10, 70, 40)];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.textColor = [UIColor redColor];
        _rightLabel.hidden = YES;
        _rightLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:_rightLabel];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
