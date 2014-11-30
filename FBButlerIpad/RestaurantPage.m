//
//  RestaurantPage.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/26/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "RestaurantPage.h"

@interface RestaurantPage ()

@end

@implementation RestaurantPage

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
    
   self.navigationItem.title = @"Restaurants";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)palaceTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}
- (IBAction)bodegaTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}
- (IBAction)primoTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}
- (IBAction)cintronTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}
- (IBAction)sushiTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}
- (IBAction)quenchTap:(id)sender {
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}

@end
