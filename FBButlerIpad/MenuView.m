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

@interface MenuView ()

//Property for Buttons on Top
@property (strong,nonatomic) NSMutableArray *buttonList;

//Properties for Table View on the left side
@property (strong,nonatomic) NSMutableArray *imageList;
@property (strong,nonatomic) NSMutableArray *nameList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign) int selectedRow;

//Properties for the right side
@property (weak, nonatomic) IBOutlet UILabel *theName;//Food Name
@property (weak, nonatomic) IBOutlet UILabel *theDescription;//Food's Description
@property (weak, nonatomic) IBOutlet UILabel *thePrice;//Price
@property (weak, nonatomic) IBOutlet UILabel *theContent;//Food's ingredients
@property (weak, nonatomic) IBOutlet UIImageView *theRating;//Star rating
@property (weak, nonatomic) IBOutlet UIImageView *theComment;//Comment

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
    self.navigationItem.title = self.getRestaurant;
    
    //Create category buttons
    [self createButton];
    
    //Following arrays are for testing purpose
    self.imageList = [NSMutableArray arrayWithObjects:
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
                     nil];
    
    [self initiateData];
    [self.tableView reloadData];
}



// Create numbers of button under the navigation bar
-(void) createButton{
    
    //Number of Category of a Restaurant
    //Subject to be changed accordingly
    int numberOfCategories = 4;
    float startpoint = 0.0f;
    self.buttonList = [[NSMutableArray alloc] init];
    
    //Type of Category of a Restaurant
    //Subject to be changed accordingly
    NSArray *categories = [NSArray arrayWithObjects:@"Appetizers", @"Pastas", @"Entrees",@"Drinks",nil];
    
    
    for(int i=0;i<numberOfCategories;i++){
        //Set up button by button: title, font, frame
        float buttonwidth =768/numberOfCategories;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(tapButton:)
         forControlEvents:UIControlEventTouchUpInside];
        
        
        [button setTitle:[categories objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if(i==0){
            //Set orange color on the first botton
            button.backgroundColor = [MenuGuide hexColor:@"E04E26"];
            //Set color white on the first botton
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.backgroundColor = [MenuGuide hexColor:@"EFE5DB"];
        }
        
        button.titleLabel.font = [UIFont fontWithName:@"Times-Bold" size:10];
        button.titleLabel.font = [UIFont systemFontOfSize:22.0f];
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
    [self resetButton];
    //Change font and background color of the selected button
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //Set orange color on the selected botton
    sender.backgroundColor = [MenuGuide hexColor:@"E04E26"];
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
    
    return [self.imageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ItemCell *cell = (ItemCell *)[tableView dequeueReusableCellWithIdentifier:@"imageCells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ItemCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    // Config cell
    // Add identation on left on food name tag
    cell.itemName.text =  [NSString stringWithFormat:@"%@%@", @"   ",self.nameList[indexPath.row]];
   
    
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
    cell.itemImage.image= self.imageList[indexPath.row];
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    //Assist to identify a selected cell in cellForRowAtIndexPath method
    self.selectedRow = -1;
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
    
    //Set the name of food on the right panel
    self.theName.text = self.nameList[indexPath.row];
    self.theName.textColor = [MenuGuide hexColor:@"AB2025"];

}

// Initiate Data on the first loading
-(void) initiateData{
    //Get the first name of food on the first category
    self.theName.text = self.nameList[0];
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
