//
//  FoodCategoryNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "FoodCategoryNetworking.h"
#import "ServerSettings.h"

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

+(NSArray*) retAllCategoriesFor:(Restaurant*) restaurant
{
    ///restaurant/id
NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@category/restaurant/%i",[ServerSettings address],restaurant.internalId]]];
    NSURLResponse *response;
    
    NSError *error;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error)
    {
        NSLog(@"ERROR: %@",error);
        return nil;
    }
    NSArray *catArray = [NSJSONSerialization
                         JSONObjectWithData:data options:0
                         error:&error];
    return [FoodCategoryNetworking makeCategoriesFromArray:catArray forRestaurant:restaurant];
    
}

+(FoodCategory*) saveCategory:(FoodCategory *)category
{
    NSString* jsonString = [FoodCategoryNetworking jsonFromCat:category];
    NSMutableURLRequest *request;
    if (category.internalId ==0)
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[ServerSettings address] stringByAppendingString:@"category" ]]];
        
        request.HTTPMethod = @"POST";
        
    }
    else
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@category/%i",[ServerSettings address],category.internalId]]];
        request.HTTPMethod = @"PUT";
    }
    NSURLResponse *response;
    
    NSError *error;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    NSLog(@"Raw json: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSDictionary *returnedCat = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    
    
    FoodCategory* foodCat = [FoodCategoryNetworking makeFoodCategoryFromDict:returnedCat forRestaurant:category.restaurant];
    return foodCat;


}

+(NSArray*) makeCategoriesFromArray:(NSArray*)jsonArray forRestaurant:(Restaurant*)restaurant
{
    NSMutableArray *foodCatArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in jsonArray)
    {
        [foodCatArray addObject:[FoodCategoryNetworking makeFoodCategoryFromDict:dict forRestaurant:restaurant]];
    }
    return foodCatArray;
}


+(FoodCategory*) makeFoodCategoryFromDict:(NSDictionary*)dict forRestaurant:(Restaurant*)restaurant
{
    FoodCategory* ret = [[FoodCategory alloc] init];
    ret.name = [dict valueForKey:@"name"];
    ret.internalId = [[dict valueForKey:@"id"] intValue];
    ret.restaurant = restaurant;
    return ret;
}

+(NSDictionary*) makeDictFromCat: (FoodCategory*) category
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (category.internalId !=0)
    {
        [dict setValue:[NSNumber numberWithInt:category.internalId] forKey:@"id"];
    }
    [dict setValue:category.name forKey:@"name"];
    [dict setValue:[NSNumber numberWithInt:category.restaurant.internalId] forKey:@"restaurant"];
    return dict;
}

+(NSString*) jsonFromCat:(FoodCategory*) category
{
    NSDictionary* dictionary = [FoodCategoryNetworking makeDictFromCat:category];
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
