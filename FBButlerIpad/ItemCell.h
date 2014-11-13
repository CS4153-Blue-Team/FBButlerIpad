//
//  ItemCell.h
//  FBButlerIpad
//
//  Created by Hung Vo on 11/12/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

//Use: Customize cells inside a table view
#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;//Food Image

@property (weak, nonatomic) IBOutlet UILabel *itemName;// Food Name Tag
@end
