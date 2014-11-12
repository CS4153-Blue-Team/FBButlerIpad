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
@property (strong,nonatomic) NSMutableArray *imageList;
@property (strong,nonatomic) NSMutableArray *nameList;
@property (strong,nonatomic) NSMutableArray *buttonList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign) int selectedRow;

//Variable for the right panel
@property (weak, nonatomic) IBOutlet UILabel *theName;
@property (weak, nonatomic) IBOutlet UILabel *theDescription;
@property (weak, nonatomic) IBOutlet UILabel *thePrice;
@property (weak, nonatomic) IBOutlet UILabel *theContent;
@property (weak, nonatomic) IBOutlet UIImageView *theRating;
@property (weak, nonatomic) IBOutlet UIImageView *theComment;

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
    
    //Create category button
    [self createButton];
    
    //Following codes are for testing purpose
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
        button.backgroundColor = [MenuGuide hexColor:@"EFE5DB"];
        button.titleLabel.font = [UIFont fontWithName:@"Times-Bold" size:10];
        button.titleLabel.font = [UIFont systemFontOfSize:22.0f];
        button.frame = CGRectMake(startpoint, 64.0, buttonwidth, 62.0);
        [self.view addSubview:button];
        startpoint+=buttonwidth;
        [self.buttonList addObject:button];
    }
}

-(void) tapButton:(UIButton*)sender{
    //Reset font and background color of all buttons
    [self resetButton];
    //Change font and background color of the selected button
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    // Note: addSubview is used to remove the default left indentation in iOS 7
    
    cell.itemName.text =  self.nameList[indexPath.row];
   
    
    //Set background color for a selected cell
    if (indexPath.row == self.selectedRow){
        cell.itemName.backgroundColor = [[MenuGuide hexColor:@"E04E26"] colorWithAlphaComponent:1.0];
        cell.itemName.textColor= [UIColor whiteColor];
    }
    else{
        cell.itemName.backgroundColor = [[MenuGuide hexColor:@"EFE5DB"] colorWithAlphaComponent:0.7];
        cell.itemName.textColor= [UIColor blackColor];
    }
    cell.itemImage.image= self.imageList[indexPath.row];
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.selectedRow = -1;
    self.selectedRow = indexPath.row;
    [self.tableView reloadData];
    
    self.theName.text = self.nameList[indexPath.row];
    self.theName.textColor = [MenuGuide hexColor:@"AB2025"];

}

-(void) initiateData{
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
