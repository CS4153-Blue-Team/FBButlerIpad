//
//  Menu Butler.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/13/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "Menu Butler.h"

@interface Menu_Butler ()

@property (weak, nonatomic) IBOutlet UIButton *editInventory;
@property (weak, nonatomic) IBOutlet UIButton *editMenu;
@property (weak, nonatomic) IBOutlet UIButton *editRestaurant;

@end

@implementation Menu_Butler

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
	// Load an image for the title on the navigation bar.
    self.navigationItem.title = @"J.W. Marriott Menu Butler";
    
    self.editInventory.alpha = .8;
    self.editMenu.alpha = .8;
    self.editRestaurant.alpha = .8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"menubutler-restaurant"]){
        EditRestaurant *sub = segue.destinationViewController;
        sub.restaurantToEdit = self.restaurant;
        sub.restName = self.restaurant.name;
        sub.restcategory = self.restaurant.type;
        sub.restHours = self.restaurant.hours;
        NSLog(@"prepareForSegue: %@", segue.identifier);
        NSLog(@"Restaurant Name: %@", sub.restaurantToEdit.name);}
    
        else if([segue.identifier isEqualToString:@"menubutler-menu"]){
        Menu *sub = segue.destinationViewController;
        sub.restaurant = self.restaurant;
        sub.sectionTitles = [FoodCategoryNetworking retAllCategoriesFor:self.restaurant];
        NSDictionary *dictionary = [MenuItemNetworking getMenuItemsFor:sub.sectionTitles];
            sub.tblDict = [dictionary mutableCopy];
        NSLog(@"prepareForSegue: %@", segue.identifier);
        
        }
    
        else if([segue.identifier isEqualToString:@"butler-Inventory"])
        {
            Inventory *sub = segue.destinationViewController;
            sub.restaurant = self.restaurant;
            
        }
        
        
    
}


- (IBAction)save:(UIStoryboardSegue *)segue
{
    EditRestaurant *editRestaurantVC = segue.sourceViewController;
    self.restaurant = editRestaurantVC.restaurantToEdit;
    [RestaurantNetworking saveRestaurant:(self.restaurant)];
    
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)editInventory:(id)sender {
    [self performSegueWithIdentifier:@"butler-Inventory" sender:self];
}
- (IBAction)tapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)tapMenu:(id)sender {
    [self performSegueWithIdentifier:@"menubutler-menu" sender:self];
}
- (IBAction)tapRestaurant:(id)sender {
    [self performSegueWithIdentifier:@"menubutler-restaurant" sender:self];
}

@end
