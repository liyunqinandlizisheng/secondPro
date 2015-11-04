//
// Copyright (c) 2010-2011 René Sprotte, Provideal GmbH
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

//#import <UIKit/UIKit.h>
//#import "MMGridViewCell.h"
//
//
//@interface MMGridViewDefaultCell : MMGridViewCell 
//{
//    UILabel *textLabel;
//    UIView *textLabelBackgroundView;
//    UIView *backgroundView;
//        
//    NSUInteger  labelHeight;
//    NSUInteger  labelInset;
//}
//
//@property (nonatomic, retain) UILabel *textLabel;
//@property (nonatomic, retain) UIView *textLabelBackgroundView;
//@property (nonatomic, retain) UIView *backgroundView;
//
//@end

#import "MMGridViewCell.h"

//@protocol MMGridViewTDefauleCellDelegate <NSObject>
//
//-(void)chickbutton:(UIButton*)button;
//
//@end

@class CCHomeListData;
@class CommonViewController;

@interface MMGridViewTDefauleCell : MMGridViewCell
{
    UILabel     *downLabel;
    UIImageView *zhuImageView;
    UIButton    *zuoImageView;
    BOOL        flg;
    UIImageView *imageView;
}

@property (nonatomic, retain) UILabel               *downLabel;
@property (nonatomic, retain) UIImageView           *zhuImageView;
@property (nonatomic, retain) UIButton              *m_DeleteBtn;
@property (nonatomic, retain) CCHomeListData        *m_HomeListData;
@property (nonatomic, retain) CommonViewController  *m_CommonViewCtrl;
@property (nonatomic, assign) BOOL                  m_bIsCollect;
@property (nonatomic, assign) BOOL                  m_bIsShowDeleteBtn;

- (id)initWithHomeListData:(CCHomeListData *)homeListData;

@end
