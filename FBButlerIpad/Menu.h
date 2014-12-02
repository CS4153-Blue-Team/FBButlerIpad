//
//  Menu.h
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSMutableDictionary *tblDict;
@property (strong, nonatomic) NSArray *indexTitles;

@end
