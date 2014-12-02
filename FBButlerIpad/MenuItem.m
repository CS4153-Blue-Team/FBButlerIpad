//
//  MenuItem.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/30/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
