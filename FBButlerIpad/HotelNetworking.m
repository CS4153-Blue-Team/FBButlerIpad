//
//  HotelFactory.m
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/16/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import "HotelNetworking.h"
#import "ServerSettings.h"

@implementation HotelNetworking

//TODO: put in image.
+(Hotel*) fakeGetHotelWithDelay:(double)seconds requestFailed: (BOOL) failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    Hotel* hotel = [[Hotel alloc]init];
    hotel.name = @"THE HOTEL";
    hotel.internalId = 802;
    hotel.image = [UIImage imageNamed:@"NavBar_J.W.png"];
    hotel.imageURL = [NSURL init];
    return hotel;
}


+(Hotel*) fakeSaveHotel:(Hotel*) hotel withDelay:(double)seconds requestFailed:(bool) failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return nil;
    NSLog(@"I would be saving a hotel with a name of %@ and a picture object: %@",hotel.name,hotel.image);
    NSLog(@"Calling id 500");
    Hotel *newHotel=[[Hotel alloc] init];
    newHotel.name = hotel.name;
    newHotel.image = hotel.image;
    newHotel.internalId = 500;
    return newHotel;
}

+(bool) fakeDeleteHotel:(Hotel*) hotel withDelay:(double) seconds requestFailed:(bool) failure
{
    [NSThread sleepForTimeInterval:seconds];
    if (failure) return false;
    NSLog(@"I would be deleting a hotel with the id of %i",hotel.internalId);
    return true;
}

+(Hotel*) retriveBaseHotel
{

    /*NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cs.okstate.edu:8080/FBButlerBackendService/rest/hotel"]];*/
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ServerSettings address]
                                                                               stringByAppendingString:@"hotel"]]];
    
    NSLog(@"A STRING: %@",[[ServerSettings address]
          stringByAppendingString:@"hotel"]);
    
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
        
    return [HotelNetworking makeHotelFromDict:testJson[0]];
}

+ (Hotel*) makeHotelFromDict:(NSDictionary*) hotelInfo
{
    Hotel *h = [[Hotel alloc] init];
    h.internalId = [[hotelInfo objectForKey:@"id"] intValue];
    h.name = [hotelInfo objectForKey:@"name"];
    if ([[hotelInfo objectForKey:@"pictureLocation"] class] != [NSNull class])
    {
        h.image = [HotelNetworking loadImageFromURL:[hotelInfo objectForKey:@"pictureLocation"]];
        h.imageURL = [NSURL URLWithString:[hotelInfo objectForKey:@"pictureLocation"]];
    }
    NSLog(@"Hotel name: %@",h.name);
    NSLog(@"The image url is %@",h.imageURL);
    return h;
}

+(NSDictionary*) makeDictFromHotel:(Hotel*) hotel
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (hotel.internalId !=0)
    {
        [dictionary setValue:[NSString stringWithFormat:@"%i",hotel.internalId]forKey:@"id"];
        
    }
    [dictionary setValue:hotel.name forKey:@"name"];
    NSLog(@"Problem = %@", hotel.imageURL);
    [dictionary setValue:[hotel.imageURL absoluteString] forKey:@"pictureLocation"];
         return dictionary;
}
         
+(NSString*) makeJSONFromHotel:(Hotel*) hotel
{
    NSDictionary *dictionary = [HotelNetworking makeDictFromHotel:hotel];
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData)
    {
        NSLog(@"Error making hotel json: %@",error);
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (UIImage*) loadImageFromURL:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
}

@end
