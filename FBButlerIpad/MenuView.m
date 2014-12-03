//
//  MenuView.m
//  FBButlerIpad
//
//  Created by Hung Vo on 11/12/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "MenuView.h"
#import "MenuGuide.h"
#import "ItemCell.h"
#import "FoodCategory.h"
#import "MenuItem.h"
#import "MenuItemNetworking.h"
#import "FoodCategoryNetworking.h"


@interface MenuView ()

//Property for Buttons on Top
@property (strong,nonatomic) NSMutableArray *buttonList;

//Properties for Table View on the left side
/*@property (strong,nonatomic) NSMutableArray *imageList;
@property (strong,nonatomic) NSMutableArray *nameList;*/

@property NSArray *categories;
@property FoodCategory *selectedCategory;
@property NSDictionary *menuItems; //Maps NAMES category objects to NSArrays of menu items

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign) int selectedRow;

//Properties for the right side
@property (weak, nonatomic) IBOutlet UILabel *theName;//Food Name

@property (weak, nonatomic) IBOutlet UITextView *theDescription;//Food Desciption

@property (weak, nonatomic) IBOutlet UILabel *thePrice;//Price

@property (weak, nonatomic) IBOutlet UILabel *dollarSign;

@end

@implementation MenuView

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
    // Set restaurant name
    self.navigationItem.title = self.restaurant.name;
       
    // Get all categories for a specific restaurant
    //self.categories = [FoodCategoryNetworking fakeGetAllCategoriesFor:self.restaurant withDelay:1 withFailure:false];
    
    self.categories = [FoodCategoryNetworking retAllCategoriesFor:self.restaurant];
    
    
    self.selectedCategory = [self.categories objectAtIndex:0] ;
    
    
    // Gell all menu items for categories in a restaurant
    //self.menuItems = [MenuItemNetworking fakeGetMenuItemsFor:self.categories withDelay:1 withFailure:false];
    
    self.menuItems = [MenuItemNetworking getMenuItemsFor:self.categories];
    
    
    //TODO: FAilure...
    
    //Create category buttons
    [self createButton];
    
    
    
    //Following arrays are for testing purpose
    /*self.imageList = [NSMutableArray arrayWithObjects:
                     [UIImage imageNamed:@"AntipastiMisti.jpg"],
                     [UIImage imageNamed:@"MusselsAlForno2.jpg"],
                     [UIImage imageNamed:@"OystersRockefeller.jpg"],
                     [UIImage imageNamed:@"PrimoLettuces.jpg"],
                     [UIImage imageNamed:@"WagyuBeefTartare.jpg"],
                     [UIImage imageNamed:@"WildMushroomTart.jpg"],
                     [UIImage imageNamed:@"WineBraisedOctopus.jpg"],
                     nil];
    self.nameList = [NSMutableArray arrayWithObjects:
                     @"Antipasti Misti",
                     @"Mussels AlForno",
                     @"Oysters Rockefeller",
                     @"Primo Lettuces",
                     @"Wagyu Beef Tartare",
                     @"Wild Mushroom Tart",
                     @"Wine Braised Octopus",
                     nil];*/
    
    [self initiateData];
    [self.tableView reloadData];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:0]; //Hacky way to get stuff to initially load
   
}



// Create numbers of button under the navigation bar
-(void) createButton{
    
    //Number of Category of a Restaurant
    //Subject to be changed accordingly
    int numberOfCategories = [self.categories count];
    float startpoint = 0.0f;
    self.buttonList = [[NSMutableArray alloc] init];
    
    
    for(int i=0;i<numberOfCategories;i++){
        //Set up button by button: title, font, frame
        float buttonwidth =768/numberOfCategories;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(tapButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        //Set title for buttons
        [button setTitle:((FoodCategory*)[self.categories objectAtIndex:i]).name forState:UIControlStateNormal];

        //[button setTitle:[categories objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if(i==0){
            //Set orange color on the first botton
            button.backgroundColor = [MenuGuide hexColor:@"E04E26"];
            //Set color white on the first botton
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.backgroundColor = [MenuGuide hexColor:@"EFE5DB"];
        }
        
        button.titleLabel.font = [UIFont fontWithName:@"Avenir-Book" size:23];
        button.titleLabel.font = [UIFont systemFontOfSize:23.0f];


        
        button.frame = CGRectMake(startpoint, 64.0, buttonwidth, 62.0);
        [self.view addSubview:button];
        startpoint+=buttonwidth;
        
        //Keep track of buttons for retrieving data later on
        [self.buttonList addObject:button];
    }
}

//Call an action when a button is tapped
-(void) tapButton:(UIButton*)sender{
    //Reset font and background color of all buttons
    for (FoodCategory* category in self.categories)
    {
        if ([category.name isEqualToString:sender.titleLabel.text])
        {
            NSLog(@"The selected category's name is: %@",category.name);
            self.selectedCategory = category;
            break;
        }
    }
    [self resetButton];
    
    //Change font and background color of the selected button
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //Set orange color on the selected botton
    sender.backgroundColor = [MenuGuide hexColor:@"E04E26"];
    
    
    [self.tableView reloadData];
    [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:0]; //HACKY WAY of making the description on the right update to first element of new table 
}


//Reset font and background color of all buttons
-(void) resetButton{
    for(UIButton* button in self.buttonList){
        //Reset font color
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //Reset background color
        button.backgroundColor = [MenuGuide hexColor:@"EFE5DB"];
    }
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    // Return the number of rows in the section.
    NSLog(@"Item before crash: %@",[[self.menuItems objectForKey:self.selectedCategory.name] class]);
    NSArray* ourArray =[self.menuItems objectForKey:self.selectedCategory.name];
    NSLog(@"Array count:%i",[ourArray count]);
    return [[self.menuItems objectForKey:self.selectedCategory.name] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:@"imageCells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    MenuItem* relevantItem = [[self.menuItems objectForKey:self.selectedCategory.name] objectAtIndex:indexPath.row];
    
    // Config cell
    // Add identation on left on food name tag
    
    cell.itemName.text =  [NSString stringWithFormat:@"%@%@", @"   ",relevantItem.name];
   
    
    //Set background color for a selected cell
    if (indexPath.row == self.selectedRow){
        //Set background organge
        cell.itemName.backgroundColor = [[MenuGuide hexColor:@"E04E26"] colorWithAlphaComponent:1.0];
        //Set text color white
        cell.itemName.textColor= [UIColor whiteColor];
    }
    else{
        //Set background beige
        cell.itemName.backgroundColor = [[MenuGuide hexColor:@"EFE5DB"] colorWithAlphaComponent:0.7];
        //Set text color black
        cell.itemName.textColor= [UIColor blackColor];
    }
    //Set approriate image
    cell.itemImage.image= relevantItem.picture;
    cell.itemMask.image= [UIImage imageNamed:@"GrayOutMenuItem.png"];

    //cell.itemImage.image= self.imageList[indexPath.row];
    if([relevantItem.name  isEqualToString: @"Primo Lettuces"]){
    //Set mask for out of stock items
        cell.itemMask.hidden = NO;
        
    }else{
        cell.itemMask.hidden = YES;
    }
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    //Assist to identify a selected cell in cellForRowAtIndexPath method
    self.selectedRow = -1;
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
    
    //Set info of food on the right panel
    MenuItem* relevantItem = (MenuItem*)((NSArray*)[self.menuItems objectForKey:self.selectedCategory.name]) [indexPath.row];
    [self setMenuItem:relevantItem];
    }



-(void) setMenuItem:(MenuItem*) item
{
    self.theName.text = item.name;
    self.theName.textColor = [MenuGuide hexColor:@"AB2025"];
    self.theDescription.text = item.description;
    
    if([item.name  isEqualToString: @"Primo Lettuces"]){
        //Set mask for out of stock items
        self.dollarSign.text = @"Out of Stock";
        self.thePrice.hidden = YES;
    }else{
        self.dollarSign.text = @"$";
        self.thePrice.hidden = NO;
        self.thePrice.text = item.price;
    }
   
}

// Initiate Data on the first loading
-(void) initiateData{
    //Get the first name of food on the first category
    self.theName.text = ((FoodCategory*)((NSArray*)[self.menuItems objectForKey:self.selectedCategory.name])[0]).name;
    self.theName.textColor = [MenuGuide hexColor:@"AB2025"];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
