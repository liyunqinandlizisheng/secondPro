//
//  DetailViewController.h
//  MobileOffice
//
//  Created by Wenrui on 15/9/11.
//  Copyright (c) 2015年 Wenrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

