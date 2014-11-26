//
//  Restaurant.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotel.h"

@interface Restaurant : NSObject

@property int internalId;
@property NSString* name;
@property Hotel* hotel;
@property UIImage* adImage;
@property NSString* type;
@property NSString* hours;

@end
