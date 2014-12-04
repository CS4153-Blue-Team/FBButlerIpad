//
//  RestaurantPage.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/26/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "RestaurantPage.h"
#import "Restaurant.h"
#import "Hotel.h"
#import "HotelNetworking.h"
#import "RestaurantNetworking.h"
#import "RestaurantCell.h"
#import "Menu Butler.h"

@interface RestaurantPage ()


@property Hotel *hotel;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


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
    
    
    [self setLoading:true]; //show activity indicator
    
    
    //This asynchronously loads restaurant over network.
    id restaurantLoad =^
    {
        //self.restaurants = [NSMutableArray arrayWithArray:[RestaurantNetworking fakeGetAllRestForHotel:self.hotel withDelay:(1) withFail:(false)]];
        self.restaurants = [NSMutableArray arrayWithArray:[RestaurantNetworking retAllRestForHotel:self.hotel]];
        
        //Updates UI based on network request.
        //This is because all UI code must run on the main threads
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.restaurants == nil || self.restaurants.count ==0)
            {
                UIAlertView *errorMessage = [[UIAlertView alloc]initWithTitle:@"Network Error"
                                                                      message:@"Error retrieving restaurants from network"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [self setLoading:false];
                [errorMessage show];
            }
            NSLog(@"HERE RESTAURANTS IS: %@",self.restaurants);
            
            [self.tableView reloadData];
            NSLog(@"HERE RESTAURANTS IS: %@",self.restaurants);
            [self setLoading:false];
            [self.activityIndicator setNeedsDisplay];
            
        });
    };
    
    //asynch block to load hotel.
    id hotelLoad = ^{
        //self.hotel = [HotelNetworking fakeGetHotelWithDelay:1 requestFailed:false];
        self.hotel = [HotelNetworking retriveBaseHotel];
        //updates ui b/c all ui updates must take place on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.hotel == nil)
            {
                UIAlertView *errorMessage = [[UIAlertView alloc]initWithTitle:@"Network Error"
                                                                      message:@"Error retrieving hotels from network"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [self setLoading:false];
                [errorMessage show];
            }
            else
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), restaurantLoad);
                self.navigationItem.titleView = [[UIImageView alloc] initWithImage:self.hotel.image];
                [self.navigationItem.titleView setNeedsDisplay];
            }
            
            
        });
    };//end hotel block
    
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), hotelLoad);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"Row in section called, returning %i",[self.restaurants count]);
    return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Requesting path %i",indexPath.row);
    
    Restaurant* restaurant = (Restaurant*)self.restaurants[indexPath.row];
    
    NSLog(@"The name of the current restaurant is %@",restaurant.name);
    
    //Make use of custom cells
    RestaurantCell *cell = (RestaurantCell *)[tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellMenuGuide" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Config cell
    //Set the background color of table view to be transparent
    
    
    //Assign restaurant's name, type, and business hours
    cell.cellName.text =  restaurant.name;
    
    
    //Get a default image for display purpose
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//Perform a segue when a restaurant is selected
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.index = indexPath;
    [self performSegueWithIdentifier:@"restaurant-menubutler" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"restaurant-menubutler"]){
        Menu_Butler *sub = segue.destinationViewController;
        sub.restaurant = self.restaurants[self.index.row];
        NSLog(@"prepareForSegue: %@", segue.identifier);
        NSLog(@"Restaurant Name: %@", sub.restaurant.name);
    }
}



-(void) setLoading:(bool) loading
{
    NSLog(@"Loading is now: %i",loading);
    NSLog(@"Current thread for setLoading: %@",[NSThread currentThread]);
    if (loading)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [self.activityIndicator startAnimating];
    }
    else
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self.activityIndicator stopAnimating];
    }
}

@end
