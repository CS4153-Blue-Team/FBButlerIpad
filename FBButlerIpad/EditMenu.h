//
//  EditMenu.h
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
#import "Menu.h"
#import "Ingredient.h"
#import "IngredientNetworking-2.h"
#import "MenuIngredientCell.h"
#import "MenuCategoryCell.h"



@interface EditMenu : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *image;
@property (weak, nonatomic) IBOutlet UITextField *category;

@property (weak, nonatomic) IBOutlet UITextView *description;


@property (weak, nonatomic) IBOutlet NSString *imageName;
@property (weak, nonatomic) IBOutlet NSString *menuName;
@property (weak, nonatomic) IBOutlet NSString *menuPrice;
@property (weak, nonatomic) IBOutlet NSString *menuDescription;
@property (strong, nonatomic) IBOutlet NSMutableArray *menuIngredients;
@property (weak, nonatomic) IBOutlet NSArray *ingredients;
@property (weak, nonatomic) IBOutlet NSArray *categories;



@property (strong,atomic) Restaurant* restaurant;
@property (strong,atomic) FoodCategory* restCategory;
@property (strong, atomic) Ingredient* ingredient;
@property (strong, atomic) MenuItem* item;



@end
