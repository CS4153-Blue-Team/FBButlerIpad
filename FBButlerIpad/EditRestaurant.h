//
//  EditRestaurant.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/16/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "RestaurantNetworking.h"

@interface EditRestaurant : UIViewController

@property (strong,atomic) Restaurant* restaurantToEdit;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *hours;

@property (weak, nonatomic) IBOutlet NSString *restName;
@property (weak, nonatomic) IBOutlet NSString *restcategory;
@property (weak, nonatomic) IBOutlet NSString *restHours;


@end
