//
//  MenuItemNetworking.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodCategory.h"
#import "MenuItem.h"

@interface MenuItemNetworking : NSObject

//Returns dictionary mapping passed in categories
//be prepared for empty dictionary(no categories stored or nil for network error)
+(NSDictionary*) fakeGetMenuItemsFor:(NSArray*) categories withDelay:(double)seconds withFailure:(bool)failure;

//Returns the saved menu item. Only will change if it was just added to the db and didn't have id
//Nil in case of failure.
+(MenuItem*) fakeSaveMenuItem:(MenuItem*)item withDelay:(double)seconds withFailure:(bool) failure;

//Returns true if menu item successfully deleted, false otherwise;
+(bool) fakeDeleteMenuItem:(MenuItem*) item withDelay:(double) seconds withFailure:(bool) failure;

@end
