//
//  IngredientNetworking.m
//  FBButlerIpad
//
//  Created by SHORT JOHN M on 12/1/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "IngredientNetworking-2.h"

@implementation IngredientNetworking2

+(Ingredient*) saveIngredient:(Ingredient *)ingredient
{
    NSMutableURLRequest *request;
    NSData* jason = [IngredientNetworking2 jsonFromIngredient:ingredient];
    if (ingredient.internalId==0)
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@ingredient", [ServerSettings address]]]];
        request.HTTPMethod = @"POST";
    }
    else
    {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@ingredient/%i", [ServerSettings address],ingredient.internalId]]];
        request.HTTPMethod = @"PUT";
    }
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:jason];
    
    NSError *error;
    
    NSURLResponse* response;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    NSLog(@"Ingredient error: %@",error);
    NSLog(@"Ingredient response: %@",response);
    
    if (error)
    {
        return nil;
    }
    
    return [IngredientNetworking2 ingredientFromJSON:data fromRestaurant:ingredient.restaurant];
}

+(NSArray*) allIngredForRest:(Restaurant *)restaurant
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@ingredient/restaurant/%i", [ServerSettings address],restaurant.internalId]]];
    
    NSURLResponse *response;
    NSError* error;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSArray* arrayOfDicts = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"%@",arrayOfDicts);
    
    NSMutableArray* arrayOfIngredients = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in arrayOfDicts)
    {
        [arrayOfIngredients addObject:[IngredientNetworking2 ingredientFromDict:dict fromRestaurant:restaurant]];
    }
    return arrayOfIngredients;
}

+(NSData*) jsonFromIngredient:(Ingredient*) ingredient
{
    NSDictionary* dictionary = [IngredientNetworking2 dictFromIngredient:ingredient ];
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData)
    {
        NSLog(@"Error making ingredient json: %@",error);
    }
    NSLog(@"Finished JSON FOR REST: %@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    return jsonData;
}

+(NSDictionary*) dictFromIngredient:(Ingredient*) ingredient
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (ingredient.internalId != 0)
    {
        [dict setValue:[NSNumber numberWithInt:ingredient.internalId] forKey:@"id"];
    }
    [dict setValue:ingredient.name forKey:@"name"];
    [dict setValue:[NSNumber numberWithBool:ingredient.inStock] forKey:@"inStock"];
    [dict setValue:[NSNumber numberWithInt:ingredient.restaurant.internalId] forKey:@"restaurant"];
    return dict;
}

+(Ingredient*) ingredientFromDict:(NSDictionary*)dict fromRestaurant:(Restaurant*) restaurant
{
    Ingredient *toReturn = [[Ingredient alloc] init];
    toReturn.internalId = [[dict objectForKey:@"id"] intValue];
    toReturn.name = [dict objectForKey:@"name"];
    toReturn.inStock = [[dict objectForKey:@"inStock" ] boolValue];
    toReturn.restaurant = restaurant;
    return toReturn;
}

+(Ingredient*) ingredientFromJSON:(NSData*) jsonData fromRestaurant:(Restaurant*) restaurant
{
    NSError *error;
    return [IngredientNetworking2 ingredientFromDict: [NSJSONSerialization JSONObjectWithData:jsonData
        options:0 error:&error] fromRestaurant:restaurant];
    
}

@end
