//
//  MOButton.m
//  MobileOffice
//
//  Created by liyunqin on 15/10/21.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import "MOButton.h"
#import "UIColor+ColorHexString.h"

@implementation MOButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
        [self addSubview:_topImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImageView.frame.origin.y + _topImageView.frame.size.height, frame.size.width, frame.size.height - _topImageView.frame.size.height)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"32f699"];
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
