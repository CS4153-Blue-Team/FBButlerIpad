//
//  EditInventory.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inventory.h"
#import "Ingredient.h"
#import "IngredientNetworking-2.h"
#import "InventoryCell.h"

@interface EditInventory : UIViewController

@property (nonatomic, strong) NSString *ingredient;

@property (strong, atomic) Ingredient *ingredientToEdit;

@property (weak, nonatomic) IBOutlet UITextField *name;


@end
