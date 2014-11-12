//
//  CustomCellMenuGuide.h
//  FBButlerIpad
//
//  Created by Hung Vo on 11/12/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellMenuGuide : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellType;
@property (weak, nonatomic) IBOutlet UILabel *cellHour;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
