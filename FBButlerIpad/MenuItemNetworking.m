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
    
    //for (FoodCategory* category in categories)
    //{
        MenuItem *mi1 = [[MenuItem alloc]init];
        MenuItem *mi2 = [[MenuItem alloc]init];
        MenuItem *mi3 = [[MenuItem alloc]init];
        MenuItem *mi4 = [[MenuItem alloc]init];
        MenuItem *mi5 = [[MenuItem alloc]init];
        MenuItem *mi6 = [[MenuItem alloc]init];
        MenuItem *mi7 = [[MenuItem alloc]init];
        MenuItem *mi8 = [[MenuItem alloc]init];
        MenuItem *mi9 = [[MenuItem alloc]init];
        MenuItem *mi10 = [[MenuItem alloc]init];
    
        mi1.name = @"Antipasti Misti";
        mi1.category = categories[1] ;
        mi1.description = @"A traditional Italian appetizer that means “before the meal” that is served with a house selection of cured meats, our daily selection of assorted cheeses, ripe, crispy artichokes, fresh citrus aioli, and tangy, marinated olives. The citrus aioli is made fresh and is made with garlic, sea salt, mayonnaise, Dijon mustard, orange zest, lemon zest, freshly squeezed lemon juice and freshly squeezed orange juice.";
        mi1.price = @"11.99";
        mi1.picture = [UIImage imageNamed:@"AntipastiMisti.jpg"];
        mi1.pictureURL = [NSURL URLWithString:@"AntipastiMisti.jpg"];
    
        
        mi2.name = @"Mussels al Forno";
        mi2.category = categories[1] ;
        mi2.description =  @"A classic seafood dish that is prepared with fresh mussels that were caught this morning. This dish contains finely chopped garlic, dry breadcrumbs, fresh olive oil, garden herbs and levain. This dish can be served hot or cold depending on your liking.";
        mi2.price = @"12.99";
        mi2.picture = [UIImage imageNamed:@"MusselsAlForno2.png"];
        mi2.pictureURL = [NSURL URLWithString:@"MusselsAlForno2.png"];
    
        
        mi3.name = @"Oysters Rockefeller";
        mi3.category = categories[1] ;
        mi3.description =  @"A popular dish that was created in New Orleans that consists of oysters on half-shell that has been topped with minced garlic, bread crumbs, shallots, chopped fresh spinach, a dash of red pepper sauce, fresh grated parmesan and the mignonette sauce. The mignonette sauce is made with champagne vinegar, shallots, peppercorns, chopped chervil and freshly squeezed lemon juice.";
        mi3.price = @"22.99";
        mi3.picture = [UIImage imageNamed:@"OystersRockefeller.png"];
        mi3.pictureURL = [NSURL URLWithString:@"OystersRockefeller.png"];
    
        mi4.name = @"Primo Lettuces";
        mi4.category = categories[3] ;
        mi4.description =  @"Our most popular salad that is served with the freshest endive lettuce, shaved radishes and a beautiful red wine vinaigrette. The red wine vinaigrette is made fresh in house daily and is made with red wine vinegar, freshly squeezed lemon juice, honey, salt & pepper, and fresh olive oil.";
        mi4.price = @"10.99";
        mi4.picture = [UIImage imageNamed:@"PrimoLettuces.png"];
        mi4.pictureURL = [NSURL URLWithString:@"PrimoLettuces.png"];
    
        mi5.name = @"Wagyu Beef Tartare";
        mi5.category = categories[3] ;
        mi5.description =  @"This popular dish is made with minced anchovies, capers, Dijon mustard, eggs, fresh USDA certified all natural Wagyu Beef that comes from sustainable family farms, red onions, Italian parsely, olive oil, a dash of hot sauce, a dash of Worcestershire sauce and crushed chili flakes.";
        mi5.price = @"12.99";
        mi5.picture = [UIImage imageNamed:@"WagyuBeefTartare.png"];
        mi5.pictureURL = [NSURL URLWithString:@"WagyuBeefTartare.png"];
    
        NSArray *itemArray1 = @[mi1,mi2,mi3,mi4,mi5];
        [returnDict setObject:itemArray1 forKey:@"Appetizers"];
    
        mi6.name = @"Coq Au Vin";
        mi6.category = categories[3] ;
        mi6.description =  @"Chicken braised in our house Pinot Nior with a kick of garlic. Served with some buttery mashed potatoes and steamed broccoli.";
        mi6.price = @"12.99";
        mi6.picture = [UIImage imageNamed:@"CoqAuVin.png"];
        mi6.pictureURL = [NSURL URLWithString:@"CogAuVin.png"];
    
    
        mi7.name = @"Golden Tile Fish";
        mi7.category = categories[3] ;
        mi7.description =  @"This popular dish is made with minced anchovies, capers, Dijon mustard, eggs, fresh USDA certified all natural Wagyu Beef that comes from sustainable family farms, red onions, Italian parsely, olive oil, a dash of hot sauce, a dash of Worcestershire sauce and crushed chili flakes.";
        mi7.price = @"12.99";
        mi7.picture = [UIImage imageNamed:@"GoldenTilefish.png"];
        mi7.pictureURL = [NSURL URLWithString:@"GoldenTilefish.png"];
    
        mi8.name = @"Grilled Prime New York Strip";
        mi8.category = categories[3] ;
        mi8.description =  @"This popular dish is made with minced anchovies, capers, Dijon mustard, eggs, fresh USDA certified all natural Wagyu Beef that comes from sustainable family farms, red onions, Italian parsely, olive oil, a dash of hot sauce, a dash of Worcestershire sauce and crushed chili flakes.";
        mi8.price = @"13.99";
        mi8.picture = [UIImage imageNamed:@"GrilledPrimeNewYorkStrip.png"];
        mi8.pictureURL = [NSURL URLWithString:@"GrilledPrimeNewYorkStrip.png"];
    
        mi9.name = @"House Aged Duck Breast";
        mi9.category = categories[3] ;
        mi9.description =  @"This popular dish is made with minced anchovies, capers, Dijon mustard, eggs, fresh USDA certified all natural Wagyu Beef that comes from sustainable family farms, red onions, Italian parsely, olive oil, a dash of hot sauce, a dash of Worcestershire sauce and crushed chili flakes.";
        mi9.price = @"22.99";
        mi9.picture = [UIImage imageNamed:@"HouseAgedDuckBreast.png"];
        mi9.pictureURL = [NSURL URLWithString:@"HouseAgedDuckBreast.png"];
    
        mi10.name = @"Hudson Valley Foi Gras";
        mi10.category = categories[3] ;
        mi10.description =  @"This popular dish is made with minced anchovies, capers, Dijon mustard, eggs, fresh USDA certified all natural Wagyu Beef that comes from sustainable family farms, red onions, Italian parsely, olive oil, a dash of hot sauce, a dash of Worcestershire sauce and crushed chili flakes.";
        mi10.price = @"10.99";
        mi10.picture = [UIImage imageNamed:@"HudsonValleyFoiGras.png"];
        mi10.pictureURL = [NSURL URLWithString:@"HudsonValleyFoiGras.png"];
    
        NSArray *itemArray2 = @[mi6,mi7,mi8,mi9,mi10];
        [returnDict setObject:itemArray2 forKey:@"Entrees"];
    
    //}
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
