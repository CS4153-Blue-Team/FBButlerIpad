//
//  RestaurantNetworking.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "RestaurantNetworking.h"
#import "HotelNetworking.h"
#import "ServerSettings.h"


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
    NSLog(@"Restaurant objects: %lu",(unsigned long)[restaurants count]);
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
}



+(NSArray*) retAllRestForHotel:(Hotel*) hotel
{
    /*NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://cs.okstate.edu:8080/FBButlerBackendService/rest/restaurant/hotel/" stringByAppendingString:[NSString stringWithFormat:@"%i",hotel.internalId]]]];*/
    /*NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[@"http://10.198.118.4:8084/FBButlerBackendService/rest/restaurant/hotel/" stringByAppendingString:[NSString stringWithFormat:@"%i",hotel.internalId]]]];*/
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@restaurant/hotel/%i",[ServerSettings address], hotel.internalId]]];
    
    
    NSURLResponse *response;
    
    NSError *error;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    NSArray *testJson = [NSJSONSerialization
                         JSONObjectWithData:data options:0
                         error:&error];
    
    if (testJson.count == 0)
    {
        return nil;
    }
    
    return [RestaurantNetworking makeRestaurantsFromArray:testJson fromHotel:hotel];
}

+(Restaurant*) saveRestaurant:(Restaurant*) restaurant
{
    NSLog(@"Save rest called");
    NSString* jsonString = [RestaurantNetworking jsonFromRest:restaurant];
    
    NSMutableURLRequest *request;
    
    
    if (restaurant.internalId ==0)
    {
        /*request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://cs.okstate.edu:8080/FBButlerBackendService/rest/restaurant"]];*/
        /*request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://10.198.118.4:8084/FBButlerBackendService/rest/restaurant"]];*/
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[[ServerSettings address] stringByAppendingString:@"restaurant"]]];
        
        request.HTTPMethod = @"POST";
    }
    else
    {
        NSLog(@"Internnal id: %i",restaurant.internalId);
        /*request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[@"http://10.198.118.4:8084/FBButlerBackendService/rest/restaurant/" stringByAppendingString:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:restaurant.internalId]]]]];*/
        
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@restaurant/%i",[ServerSettings address], restaurant.internalId]]];
        
        request.HTTPMethod=@"PUT";
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSError *error;
    
    NSURLResponse* response;
    
    NSLog(@"ABOVE");
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    //TODO: RESPOND TO ERROR!!!, return correct restaurant.
    NSLog(@"Below");
    NSLog(@"Restaurant error: %@",error);
    NSLog(@"Response: %@",response);
    NSLog(@"Data: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSDictionary *returnedRestDict =[NSJSONSerialization
                                 JSONObjectWithData:data options:0
                                 error:&error];
    if (error)
    {
        return nil;
    }
    Restaurant *returnedRest = [RestaurantNetworking makeRestaurantFromDict:returnedRestDict withHotel:restaurant.hotel];
    return returnedRest;
    
    
    //read and return returned restaurant
}

+(bool) deleteRestaurant:(Restaurant *)restaurant
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@restaurant/%i",[ServerSettings address], restaurant.internalId]]];
     request.HTTPMethod=@"DELETE";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //[request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error;
    
    NSURLResponse* response;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSLog(@"Restaurant delete error: %@",error);
    NSLog(@"Response delete: %@",response);
    NSLog(@"Data: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    return true;

}

+(NSArray*) makeRestaurantsFromArray:(NSArray*) array fromHotel:(Hotel*) hotel
{
    NSMutableArray *restaurants = [[NSMutableArray alloc]init];
    for (NSDictionary* dict in array)
    {
        
        [restaurants addObject:[RestaurantNetworking makeRestaurantFromDict:dict withHotel:hotel]];
    }
    return restaurants;
}

+(Restaurant*) makeRestaurantFromDict:(NSDictionary*) dict withHotel:(Hotel*) hotel
{
    Restaurant *rest = [[Restaurant alloc] init];
    rest.internalId = [[dict objectForKey:@"id"] intValue];
    rest.hotel = hotel;
    rest.name = (NSString*) [dict objectForKey:@"restaurantName"];
    //skipping ad image
    rest.type = (NSString*)[dict objectForKey:@"type"];
    rest.hours = (NSString*)[dict objectForKey:@"hours"];
    return rest;
}

+(NSDictionary*) dictFromRest:(Restaurant*) restaurant
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    
    if (restaurant.internalId != 0)
    {
        [dict setValue: [NSNumber numberWithInt:restaurant.internalId] forKey:@"id"];
    }
    [dict setValue:[NSNumber numberWithInt: restaurant.hotel.internalId ] forKey:@"hotel"];
    [dict setValue:restaurant.name forKey:@"restaurantName"];
    [dict setValue:@"X" forKey:@"advertisingImage"];
    [dict setValue:restaurant.type forKey:@"type"];
    [dict setValue:restaurant.hours forKey:@"hours"];
    [dict setValue:@"Unused" forKey:@"advertisingImage"];
    return dict;
}

+(NSString*) jsonFromRest: (Restaurant*) restaurant
{
    NSDictionary* dictionary = [RestaurantNetworking dictFromRest:restaurant];
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData)
    {
        NSLog(@"Error making restaurant json: %@",error);
    }
    NSLog(@"Finished JSON FOR REST: %@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
