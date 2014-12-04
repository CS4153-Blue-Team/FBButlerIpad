//
//  MenuCell.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 12/3/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize cellName = _cellName;

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
