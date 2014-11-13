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

@interface MenuGuide ()

@property (strong,nonatomic) NSMutableArray *name;//Restaurant's name
@property (strong,nonatomic) NSMutableArray *type;//Restaurant's type
@property (strong,nonatomic) NSMutableArray *hour;//Restaurant's hours

//Used to get a restaurant's name from a selected cell
@property (strong,nonatomic) NSIndexPath *index;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



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

    

    [self setupList];
}

-(void) setupList{
    //Following arrays are for testing purpose
    self.name = [NSMutableArray arrayWithObjects:
                     @"Primo",
                     @"Cintron",
                     @"Sushi Bar",
                     @"Quench",
                     @"Cafe Bodega",
                     @"Golden Palace",
                     nil];
    self.type = [NSMutableArray arrayWithObjects:
                 @"Italian",
                 @"American",
                 @"Japanese",
                 @"Bar and Grill",
                 @"Sandwiches",
                 @"Chinese",
                 nil];
    self.hour = [NSMutableArray arrayWithObjects:
                 @"6p-10,Th-Sun",
                 @"8a-8p, Daily",
                 @"6p-10p,Mo-Fr",
                 @"6p-10p,Daily",
                 @"11a-10p,Daily",
                 @"8a-8p, Daily",
                 nil];
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
    return [self.name count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    cell.cellName.text =  self.name[indexPath.row];
    cell.cellType.text = self.type[indexPath.row];
    cell.cellHour.text = self.hour[indexPath.row];
    
    //Get a default image for display purpose
    cell.cellImage.image = [UIImage imageNamed:@"Page1_RestaurantButton.png"];
    
    
    
    return cell;
}

//Perform a segue when a restaurant is selected
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.index = indexPath;
    [self performSegueWithIdentifier:@"menuguide-menuview" sender:self];
}

//Set up a color based on hex values (form: #FFFFFF)
+(UIColor*)hexColor:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



#pragma mark - Navigation
// Prepare for segue before moving to Menu View
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"menuguide-menuview"]){
        MenuView *sub = segue.destinationViewController;
        sub.getRestaurant = self.name[self.index.row];
    }
}


@end
