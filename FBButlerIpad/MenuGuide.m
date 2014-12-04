//
//  MenuGuide.m
//  FBButlerIpad
//
//  Created by Hung Vo on 11/11/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "MenuGuide.h"
#import "MenuView.h"
#import "CustomCellMenuGuide.h"
#import "Restaurant.h"
#import "Hotel.h"
#import "HotelNetworking.h"
#import "RestaurantNetworking.h"
#import "FoodCategoryNetworking.h"


@interface MenuGuide ()

@property NSMutableArray *restaurants;
@property Hotel* hotel;

//Used to get a restaurant's name from a selected cell
@property (strong,nonatomic) NSIndexPath *index;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//To check if a restaurant has any menu
@property NSArray *categories;

@end

@implementation MenuGuide

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
    //Load a image for the title on navigatin bar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBar_J.W.png"]];
    
    //Set title to be matched with the design
    self.navigationItem.title = @"Home";

    [self setLoading:true]; //show activity indicator
    
    
    //This asynchronously loads restaurant over network.
    id restaurantLoad =^
    {
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
            
        
            [self.tableView reloadData];
            [self setLoading:false];
            [self.activityIndicator setNeedsDisplay];

        });
    };
    
    //asynch block to load hotel.
    id hotelLoad = ^{
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
            }
            

        });
    };//end hotel block
    
    //starts hotel networking code
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), hotelLoad);
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Requesting path %i",indexPath.row);
    
    Restaurant* restaurant = (Restaurant*)self.restaurants[indexPath.row];
    
    NSLog(@"The name of the current restaurant is %@",restaurant.name);
    
    //Make use of custom cells
    CustomCellMenuGuide *cell = (CustomCellMenuGuide *)[tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellMenuGuide" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Config cell
    //Set the background color of table view to be transparent
    cell.backgroundColor = [UIColor clearColor];
    
    //Assign restaurant's name, type, and business hours
    cell.cellName.text =  restaurant.name;
    cell.cellType.text = restaurant.type;
    cell.cellHour.text = restaurant.hours;
    
    //Get a default image for display purpose
    cell.cellImage.image = [UIImage imageNamed:@"Page1_RestaurantButton.png"];
    
    return cell;
}

//Perform a segue when a restaurant is selected
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
     Restaurant* restaurant = (Restaurant*)self.restaurants[indexPath.row];
    NSString *msg = [NSString stringWithFormat:@"Menu of %@ is not available at this moment.", restaurant.name];
    
    //Start the network indicator when a restaurant is selected
    [self setLoading:true];
    //This asynchronously loads category of a restaurant over network.
    id categoryLoad = ^{
        self.categories = [FoodCategoryNetworking retAllCategoriesFor:restaurant];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setLoading:false];
            [self.activityIndicator setNeedsDisplay];
            self.categories = [FoodCategoryNetworking retAllCategoriesFor:restaurant];
            if (self.categories == nil || self.categories.count ==0)
            {
                UIAlertView *errorMessage = [[UIAlertView alloc]initWithTitle:@"No Menu"
                                                                      message:msg
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [errorMessage show];
            }else{
                //Go to selected restaurant's menu
                [self performSegueWithIdentifier:@"menuguide-menuview" sender:self];
            }
            //End network indicator
            [self setLoading:false];
            [self.activityIndicator setNeedsDisplay];
            
            
        });//end dispatch_async
    };//end categoryLoad
    //Start the category block
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), categoryLoad);
}

//Set up a color based on hex values (form: #FFFFFF)
+(UIColor*)hexColor:(NSString*)hex
{
    NSString *color = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // Separate into red, green, blue substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *red = [color substringWithRange:range];
    
    range.location = 2;
    NSString *green = [color substringWithRange:range];
    
    range.location = 4;
    NSString *blue = [color substringWithRange:range];
    
    // Scan values
    unsigned int redValue, greenValue, blueValue;
    [[NSScanner scannerWithString:red] scanHexInt:&redValue];
    [[NSScanner scannerWithString:green] scanHexInt:&greenValue];
    [[NSScanner scannerWithString:blue] scanHexInt:&blueValue];
    
    return [UIColor colorWithRed:((float) redValue / 255.0f)
                           green:((float) greenValue/ 255.0f)
                            blue:((float) blueValue / 255.0f)
                           alpha:1.0f];
}

///Does 2 things:
// - Blocks ui input/ freezes screen
// - Turns activity indicator on or off
-(void) setLoading:(bool) loading
{
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

#pragma mark - Navigation
// Prepare for segue before moving to Menu View
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"menuguide-menuview"]){
        MenuView *sub = segue.destinationViewController;
        sub.restaurant = self.restaurants[self.index.row];
    }
}


@end
