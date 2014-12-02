//
//  MenuItemNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "MenuItemNetworking.h"
#import "ServerSettings.h"
#import "Ingredient.h"

@implementation MenuItemNetworking

+(NSDictionary*) fakeGetMenuItemsFor:(NSArray*) categories withDelay:(double)seconds withFailure:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
    
    for (FoodCategory* category in categories)
    {
        MenuItem *mi1 = [[MenuItem alloc]init];
        MenuItem *mi2 = [[MenuItem alloc]init];
        
        mi1.name = [NSString stringWithFormat:@"Item 1 cat: %@",category.name];
        mi1.category = category;
        mi1.description = @"MENU ITEM 1 DESCRIPTion";
        mi1.price = @"1.99";
        mi1.picture = [UIImage imageNamed:@"AntipastiMisti.jpg"];
        mi1.pictureURL = [NSURL URLWithString:@"AntipastiMisti.jpg"];
        
        mi2.name = @"Item 2";
        mi2.category = category;
        mi2.description =  @"MENU ITEM 2 DESCRIPTion";
        mi2.price = @"2.99";
        mi2.picture = [UIImage imageNamed:@"WagyuBeefTartare.jpg"];
        mi2.pictureURL = [NSURL URLWithString:@"AntipastiMisti.jpg"];
        
        NSArray *itemArray = @[mi1,mi2];
        [returnDict setObject:itemArray forKey:category.name]; 
    }
    return returnDict;
}

+(MenuItem*) fakeSaveMenuItem:(MenuItem *)item withDelay:(double)seconds withFailure:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    
    NSLog(@"FAKE Saving name for %@",item.name);
    return item;
}

+(bool) fakeDeleteMenuItem:(MenuItem *) item withDelay:(double) seconds withFailure:(bool) failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return false;
    
    NSLog(@"Fake deleting item with name %@",item.name);
    return true;
}

+(NSDictionary*) getMenuItemsFor:(NSArray*) categories
{
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
    for (FoodCategory* category in categories)
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@menuItem/category/%i",[ServerSettings address], category.internalId]]];
        NSURLResponse *response;
        
        NSError *error;
        
        NSData* data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        if (error)
        {
            NSLog(@"Error: %@",error);
            return nil;
        }
        
        NSArray *categoryItems = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSArray* itemArray = [MenuItemNetworking itemFromArray:categoryItems withCategory:category];
        [returnDict setObject:itemArray forKey:category.name];
    }
    return returnDict;
}

+(NSArray*) itemFromArray:(NSArray*) itemsArray withCategory:(FoodCategory*) category
{
    NSMutableArray* menuItems = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in itemsArray)
    {
        [menuItems addObject:[MenuItemNetworking itemFromDict:dict withCategory:category]];
    }
    return menuItems;
}

+ (MenuItem*) itemFromDict:(NSDictionary*) dict withCategory:(FoodCategory*) category
{
    MenuItem *item = [[MenuItem alloc] init];
    item.internalId = [[dict objectForKey:@"id"] intValue];
    item.name = [dict objectForKey:@"name"];
    item.description = [dict objectForKey:@"description"];
    item.pictureURL = [dict objectForKey:@"pictureFile"];
    //NOT DOING B/C NOTHING IS LIVE ON THE SERVER...
    //item.picture = [UIImage imageWithData:[NSData dataWithContentsOfURL:item.pictureURL]];  //network request, might cause delay
    item.reviewImage = nil; //@"UNUSED?";
    item.category = category;
    item.price = [dict objectForKey:@"price"];
    item.ingredients = [MenuItemNetworking retIngredientsFor:item];
    return item;
}

+(NSArray*) retIngredientsFor:(MenuItem*) item
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@ingredient/menuItem/%i",[ServerSettings address], item.internalId]]];
    
    NSURLResponse *response;
    
    NSError *error;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSArray* itemIngredsDicts = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    return [MenuItemNetworking ingredientsFromDicts:itemIngredsDicts forRestaurant:item.category.restaurant];
    
    
}

+(MenuItem*) saveMenuItem:(MenuItem*) menuItem
{

    
    NSString* jsonString = [MenuItemNetworking jsonFromMenuItem:menuItem];
    NSMutableURLRequest *request;
    if (menuItem.internalId != 0)
    {
         request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@menuItem/%i",[ServerSettings address],menuItem.internalId]]];
        request.HTTPMethod = @"PUT";
    }
    else
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@menuItem",[ServerSettings address]]]];
        request.HTTPMethod = @"POST";
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"HTTP BODY: %@",jsonString);
    
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error;
    
    NSURLResponse* response;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                    error:&error];
    //NSLog(@"URL WE TRIED: %@",[request.URL absoluteString]);
    NSLog(@"Response: %@",response);
    NSLog(@"ERROR: %@",error);
    NSLog(@"Menu item save return: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    
    
    return [MenuItemNetworking itemFromDict:responseDict withCategory:menuItem.category];
    
    
}

+(NSArray*) ingredientsFromDicts:(NSArray*) dicts forRestaurant:(Restaurant*) restaurant
{
    NSMutableArray* ingreds = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dicts)
    {
        Ingredient *ingred = [[Ingredient alloc] init];
        ingred.internalId = [[dict objectForKey:@"id" ] intValue];
        ingred.name = [dict objectForKey:@"name"];
        ingred.inStock = [[dict objectForKey:@"inStock"] boolValue];
        [ingreds addObject:ingred];
    }
    return ingreds;
}

+(NSDictionary*) dictFromMenuItem:(MenuItem*) menuItem
{
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
    if (menuItem.internalId !=0)
    {
        [returnDict setValue:[NSNumber numberWithInt:menuItem.internalId] forKey:@"id"];
    }
    [returnDict setValue:menuItem.name forKey:@"name"];
    [returnDict setValue:menuItem.description forKey:@"description"];
    NSLog(@"Picture URL:%@",menuItem.pictureURL);
    /*if (menuItem.pictureURL != NULL && menuItem.pictureURL != nil)
    {
        [returnDict setValue:[menuItem.pictureURL absoluteString] forKey:@"pictureFile"] ;
    }*/
    [returnDict setValue:[NSNumber numberWithDouble:[menuItem.price doubleValue]] forKey:@"price"];
    [returnDict setValue:@"unused" forKey:@"reviewImageLocation"];
    [returnDict setValue:[NSNumber numberWithInt:menuItem.category.internalId] forKey:@"category"];
    return returnDict;
}

+(NSString*) jsonFromMenuItem:(MenuItem*) menuItem
{
    NSDictionary* dictionary = [MenuItemNetworking dictFromMenuItem:menuItem];
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData)
    {
        NSLog(@"Error making menu item json: %@",error);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
