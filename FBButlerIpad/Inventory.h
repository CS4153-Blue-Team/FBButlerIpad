//
//  Inventory.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InventoryCell.h"
#import "EditInventory.h"

@interface Inventory : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSMutableDictionary *tblDict;
@property (strong, nonatomic) NSArray *indexTitles;

@end
