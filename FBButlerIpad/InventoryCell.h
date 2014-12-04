//
//  InventoryCell.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/28/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryCell : UITableViewCell

@property (weak, nonatomic) NSString *name;

@property (weak, nonatomic) IBOutlet UILabel *cellName;

@end
