//
//  FoodCategoryNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "FoodCategoryNetworking.h"

@implementation FoodCategoryNetworking

// only returns 2 now
+(NSArray*) fakeGetAllCategoriesFor:(Restaurant *)restaurant withDelay:(double)seconds withFailure:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    
    FoodCategory* category1 = [[FoodCategory alloc ] init];
    FoodCategory* category2 = [[FoodCategory alloc ] init];
    
    category1.name = @"Food category1";
    category1.restaurant = restaurant;
    
    category2.name = @"Food category2";
    category2.restaurant = restaurant;
    
    return @[category1,category2];
}

+(FoodCategory*) fakeSaveCategory:(FoodCategory *)category withDelay:(double)seconds withFailure:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    
    NSLog(@"saving food category %@",category.name);
    if (category.internalId ==0)
    {
        NSLog(@"No internal id detected. Assigning 385");
        category.internalId =385;
        ;
    }
    return category;
}

+(bool) fakeDeleteCategory:(FoodCategory *)category withDelay:(double)seconds withFailure:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return false;
    
    NSLog(@"Deleting %@", category.name);
    return true;
}

@end
