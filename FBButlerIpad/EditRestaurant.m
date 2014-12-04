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
    
    self.navigationItem.title = @"Edit Restaurant";
    self.name.text = self.restName;
    self.category.text = self.restcategory;
    self.hours.text = self.restHours;
    
    
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveRest"])
    {
        self.restaurantToEdit.name = self.name.text;
        self.restaurantToEdit.name = [self.restaurantToEdit.name capitalizedString];
        
        self.restaurantToEdit.type = self.category.text;
        self.restaurantToEdit.type = [self.restaurantToEdit.type capitalizedString];
        
        self.restaurantToEdit.hours = self.hours.text;
        self.restaurantToEdit.hours = [self.restaurantToEdit.hours capitalizedString];
    }
}

@end
