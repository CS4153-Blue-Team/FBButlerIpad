//
//  MenuGuide.h
//  FBButlerIpad
//
//  Created by Hung Vo on 11/11/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuGuide : UIViewController <UITableViewDataSource,UITableViewDelegate>

//Public class method to set a color with 6 digits hex string e.g @"#FFFFFF"
+(UIColor*)hexColor:(NSString*)hex;


@end
