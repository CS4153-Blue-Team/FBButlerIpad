//
//  CustomCellMenuGuide.h
//  FBButlerIpad
//
//  Created by Hung Vo on 11/12/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.


//Use: Customize cells inside a table view

#import <UIKit/UIKit.h>

@interface CustomCellMenuGuide : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellName;//Restaurant's name
@property (weak, nonatomic) IBOutlet UILabel *cellType;//Restaurant's type
@property (weak, nonatomic) IBOutlet UILabel *cellHour;//Restaurant's hours
@property (weak, nonatomic) IBOutlet UIImageView *cellImage; //Cell image

@end
