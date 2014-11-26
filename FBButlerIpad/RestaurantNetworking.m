//
//  RestaurantNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "RestaurantNetworking.h"


@implementation RestaurantNetworking

//right now just returns 2
+(NSArray*) fakeGetAllRestForHotel:(Hotel *)hotel withDelay:(double)seconds withFail:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
   
    NSMutableArray* restaurants = [[NSMutableArray alloc] init];
    Restaurant* restaurant = [[Restaurant alloc] init];
    Restaurant* restaurant2 = [[Restaurant alloc] init];
    
    
    restaurant.internalId= 100;
    restaurant.name = @"Restaurant 1";
    restaurant.hotel = hotel;
    //restaurant.buttonImage = [UIImage imageNamed:@"Page1_RestaurantButton.png"];
    restaurant.type = @"Type 1";
    restaurant.hours = @"1-4";
    [restaurants addObject:restaurant];
    
    restaurant2.internalId = 101;
    restaurant2.name = @"Restaurant 2";
    restaurant2.hotel = hotel;
    restaurant2.type = @"Type of 2";
    restaurant2.hours = @"2-5";
    [restaurants addObject: restaurant2];
    NSLog(@"Restaurant objects: %i",[restaurants count]);
    return [NSArray arrayWithArray:restaurants];
    
}

+(Restaurant*) fakeSaveRest:(Restaurant *)restaurant withDelay:(double)seconds withFail:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    
    NSLog(@"Saving restaurant with name %@",restaurant.name);
    if (restaurant.internalId>0)
    {
        NSLog(@"It has an id so we would treat this an update");
        return restaurant;
    }
    else
    {
        NSLog(@"Has an id of 0 so we assume have to save");
        NSLog(@"Pretending restaurant has id of 402");
        restaurant.internalId = 402;
        return restaurant;
    }
}

+(bool) fakeDelRest:(Restaurant *)restaurant withDelay:(double)seconds withFail:(bool)failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return false;
    NSLog(@"Pretending to delete restaurant %@",restaurant.name);
    return true;
};
@end
