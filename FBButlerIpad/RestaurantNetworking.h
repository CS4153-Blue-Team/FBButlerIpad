//
//  RestaurantNetworking.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface RestaurantNetworking : NSObject

//Be able to react if this is empty!!
//Returns a list of all restaurants for the hotel.
//Returns nil if there is a failure
+(NSArray*) fakeGetAllRestForHotel:(Hotel*) hotel withDelay:(double) seconds withFail:(bool)failure;

//Returns the version of the restaurant saved. Is a pass by reference anyway. It would only be different if the
//restaurant hadn't been saved yet and needed to be assigned an id by the database.
//OR NIL if something goes wrong
//
+(Restaurant*) fakeSaveRest:(Restaurant*) restaurant withDelay:(double) seconds withFail:(bool) failure;

//Returns true if deletion succeeded, false otherwise
+(bool) fakeDelRest:(Restaurant*) restaurant withDelay:(double) seconds withFail:(bool) failure;

@end
