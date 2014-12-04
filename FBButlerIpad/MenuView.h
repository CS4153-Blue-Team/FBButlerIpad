//
//  MenuView.h
//  FBButlerIpad
//
//  Created by Hung Vo on 11/12/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface MenuView : UIViewController
//@property (strong,nonatomic) NSString* getRestaurant;
@property (strong,atomic) Restaurant* restaurant;

@end
