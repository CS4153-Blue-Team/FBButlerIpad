//
//  Ingredient.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface Ingredient : NSObject

@property int internalId;
@property NSString* name;
@property bool inStock;
@property Restaurant* restaurant;  //might not need??

@end
