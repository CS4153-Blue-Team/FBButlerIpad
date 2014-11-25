//
//  HotelFactory.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/16/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotel.h"

@interface HotelNetworking : NSObject

//SIMULATES GETTING A HOTEL OVER THE NETWORK
//Returns "main" hotel or nil if request fails.
+(Hotel*) fakeGetHotelWithDelay:(double)seconds requestFailed: (BOOL) failure;

//SIMULATES saving a hotel over the network
//returns a hotel object w/ database id or nil if request fails
+(Hotel*) fakeSaveHotel:(Hotel*) hotel withDelay:(double)seconds requestFailed:(bool) failure;

//SIMULATES deleting a hotel over the network.
//Returns true if deletion succeeded, false otherwise
+(bool) fakeDeleteHotel:(Hotel*) hotel withDelay:(double) seconds requestFailed:(bool) failure;


//RETRIEVES ALL HOTELS OVER NETWORK, returns first one in list or nil if request failed.
+(Hotel*) retriveBaseHotel;
@end
