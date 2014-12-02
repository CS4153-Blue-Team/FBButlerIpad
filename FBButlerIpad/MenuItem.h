//
//  MenuItem.h
//  TESTNETWORK
//
//  Created by SHORT JOHN M on 11/18/14.
//  Copyright (c) 2014 SHORT JOHN M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodCategory.h"

@interface MenuItem : NSObject

@property int internalId;
@property NSString* name;
@property FoodCategory* category;
@property NSString* description; //Synthesized in main class
@property UIImage* picture;
@property NSURL* pictureURL;
@property NSString* price; //Intentionally making a string!
@property UIImage* reviewImage;
@property NSArray* ingredients;



@end
