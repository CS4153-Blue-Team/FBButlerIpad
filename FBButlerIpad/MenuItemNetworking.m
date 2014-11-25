//
//  MenuItemNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "MenuItemNetworking.h"

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
        
        mi2.name = @"Item 2";
        mi2.category = category;
        mi2.description =  @"MENU ITEM 2 DESCRIPTion";
        mi2.price = @"2.99";
        mi2.picture = [UIImage imageNamed:@"WagyuBeefTartare.jpg"];
        
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

@end
