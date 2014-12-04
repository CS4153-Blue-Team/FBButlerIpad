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


@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *menuName;
@property (strong, nonatomic) NSString *menuPrice;
@property (strong, nonatomic) NSString *menuDescription;
@property (strong, nonatomic) NSMutableArray *menuIngredients;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSArray *categories;



@property (strong,atomic) Restaurant* restaurant;
@property (strong,atomic) FoodCategory* restCategory;
@property (strong, atomic) Ingredient* ingredient;
@property (strong, atomic) MenuItem* item;



@end
