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
#import "Restaurant.h"
#import "RestaurantNetworking.h"
#import "Ingredient.h"
#import "IngredientNetworking-2.h"

@interface Inventory : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) NSString *name;

@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSMutableDictionary *tblDict;
@property (strong, nonatomic) NSArray *indexTitles;
@property (strong, nonatomic) NSIndexPath *index;
@property (strong,atomic) Restaurant* restaurant;

@end
