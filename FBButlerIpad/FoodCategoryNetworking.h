//
//  FoodCategoryNetworking.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "FoodCategory.h"


@interface FoodCategoryNetworking : NSObject


// Prepared to react to empty array!
//Returns an array of all food categories for the restaurant
//Or returns nil if network request failed
+(NSArray*) fakeGetAllCategoriesFor:(Restaurant*) restaurant withDelay:(double) seconds withFailure: (bool)failure;

//Returns the version of the food category that was saved.
//It would only be different than the one returned if the category was being saved for the first time and was assigned an internal id by the database.
//Will return nil if there was a network error.
+(FoodCategory*) fakeSaveCategory:(FoodCategory*) category withDelay:(double) seconds withFailure:(bool) failure;

//Returns true if category was successfully deleted, false otherwise
+(bool) fakeDeleteCategory:(FoodCategory*) category withDelay:(double) seconds withFailure:(bool) failure;

+(NSArray*) retAllCategoriesFor:(Restaurant*) restaurant;

+(FoodCategory*) saveCategory:(FoodCategory*) category;
@end
