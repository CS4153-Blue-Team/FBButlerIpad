//
//  IngredientNetworking.h
//  FBButlerIpad
//
//  Created by SHORT JOHN M on 12/1/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"
#import "ServerSettings.h"

@interface IngredientNetworking2 : NSObject

+(Ingredient*) saveIngredient: (Ingredient*) ingredient;

+(NSArray*) allIngredForRest:(Restaurant*) restaurant;

@end
