//
//  Menu.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h"
#import "Restaurant.h"
#import "RestaurantNetworking.h"
#import "FoodCategory.h"
#import "FoodCategoryNetworking.h"
#import "MenuItem.h"
#import "MenuItemNetworking.h"
#import "EditMenu.h"
#import "Ingredient.h"
#import "IngredientNetworking-2.h"


@interface Menu : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSMutableDictionary *tblDict;
@property (strong, nonatomic) NSArray *indexTitles;
@property (strong, nonatomic) NSIndexPath *index;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSArray *categories;

@property (strong,atomic) Restaurant* restaurant;

@end
