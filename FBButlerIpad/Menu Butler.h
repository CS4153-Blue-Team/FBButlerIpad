//
//  Menu Butler.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/13/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "RestaurantNetworking.h"
#import "EditRestaurant.h"
#import "FoodCategory.h"
#import "FoodCategoryNetworking.h"
#import "MenuItem.h"
#import "MenuItemNetworking.h"
#import "Menu.h"
#import "Inventory.h"
#import "Ingredient.h"
#import "IngredientNetworking-2.h"

@interface Menu_Butler : UIViewController

@property (strong,atomic) Restaurant* restaurant;

@end
