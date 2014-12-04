//
//  RestaurantPage.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/26/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantPage : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property NSMutableArray *restaurants;
@property (strong, nonatomic) NSIndexPath *index;

@end
