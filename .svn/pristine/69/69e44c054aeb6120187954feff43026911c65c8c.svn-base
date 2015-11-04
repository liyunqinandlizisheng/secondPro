//
//  MyInfoCell.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/19.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MyInfoCell.h"
#import "UIColor+ColorHexString.h"

#define kLeftLabelTag 3000
#define kContentLabelTag 3001

@implementation MyInfoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCellView
{
    _leftLabel = (UILabel *) [self viewWithTag:kLeftLabelTag];
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 90, 40)];
        _leftLabel.tag = kLeftLabelTag;
        _leftLabel.font = [UIFont systemFontOfSize:18];
        _leftLabel.textColor = [UIColor blackColor];
        [self addSubview:_leftLabel];
    }
    
    _contentLabel = (UILabel *) [self viewWithTag:kContentLabelTag];
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftLabel.frame.origin.x + _leftLabel.frame.size.width + 10, 5, 170, 40)];
        _contentLabel.tag = kContentLabelTag;
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textColor = [UIColor colorWithHexString:@"848484"];
        [self addSubview:_contentLabel];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
