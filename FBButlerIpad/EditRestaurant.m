//
//  EditRestaurant.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/16/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "EditRestaurant.h"

@interface EditRestaurant ()

@end

@implementation EditRestaurant

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"EditRestaurantTitle.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tapCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
