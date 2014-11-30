//
//  Inventory.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "Inventory.h"


@interface Inventory ()

@property (strong, nonatomic) NSIndexPath *inventoryIndex;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation Inventory


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
    self.navigationItem.title = @"Ingredients Inventory";
    
    [self setupList];
    
    
    
}

-(void)setupList
{
  
    self.tblDict = [[NSMutableDictionary alloc] init];
    [self.tblDict setObject:@[@"Anchovies", @"Artichoke"] forKey:@"A"];
	[self.tblDict setObject:@[@"Bacon", @"Bay Leaf", @"Beef", @"Bitters", @"Black Beans", @"Breadcrumbs", @"Butter"] forKey:@"B"];
	[self.tblDict setObject:@[@"Cabbage", @"Carrot", @"Capers", @"Champagne Vinegar", @"Chervil", @"Chicken", @"Chicken Stock", @"Chili Flakes", @"Chives", @"Citrus Vodka", @"Cognac",  @"Corn", @"Club Soda", @"Cumin"] forKey:@"C"];
    [self.tblDict setObject:@[@"Dijon Mustard", @"Duck"] forKey:@"D"];
    [self.tblDict setObject:@[@"Egg"] forKey:@"E"];
    [self.tblDict setObject:@[@"Garlic Cloves", @"Golden Tile Fish", @"Grapefruit Juice"] forKey:@"G"];
    [self.tblDict setObject:@[@"Honey", @"Hot Sauce"] forKey:@"H"];
    [self.tblDict setObject:@[@"Foie Gras", @"Flat-leaf Parsley", @"Flour"] forKey:@"F"];
    [self.tblDict setObject:@[@"Lemon", @"Lettuce", @"Levain"] forKey:@"L"];
    [self.tblDict setObject:@[@"Maraschino Cherries", @"Mayonnaise", @"Mushroom", @"Mussels"] forKey:@"M"];
    [self.tblDict setObject:@[@"Olive Juice", @"Olive Oil", @"Onion", @"Orange", @"Oysters"] forKey:@"O"];
    [self.tblDict setObject:@[@"Parmesan Cheese", @"Parsley", @"Pepper", @"Peppercorn", @"Pinot Noir", @"Potato"] forKey:@"P"];
    [self.tblDict setObject:@[@"Radish", @"Red Onion", @"Red Pepper", @"Red Wine Vinegar", @"Rolls", @"Romaine"] forKey:@"R"];
    [self.tblDict setObject:@[@"Saint Germaine", @"Salt", @"Sea Salt", @"Shallots", @"Simple Syrup", @"Sparkling Soda", @"Spinach", @"Steak"] forKey:@"S"];
    [self.tblDict setObject:@[@"Tequila", @"Thyme", @"Tomato Paste", @"Tonic"] forKey:@"T"];
    [self.tblDict setObject:@[@"Unsalted Butter"] forKey:@"U"];
    [self.tblDict setObject:@[@"Vermouth Grey Goose", @"Vinaigrette", @"Vodka"] forKey:@"V"];
    [self.tblDict setObject:@[@"Worcestershire Sauce"] forKey:@"W"];
    [self.tblDict setObject:@[@"Yellow Onion"] forKey:@"Y"];
    
    
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    NSArray *array = [self.tblDict objectForKey:@"A"];
    array2 = [array mutableCopy];
    [array2 addObject:@"Chris"];
    [self.tblDict setObject:(array2) forKey:@"A"];
    
    self.sectionTitles = [[self.tblDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.indexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:section];
    NSArray *sectionTitles= [self.tblDict objectForKey:sectionTitle];
    return [sectionTitles count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    [header setBackgroundColor:[UIColor colorWithRed: 244.0/255.0f
                                               green: 233.0/255.0f
                                                blue: 225.0/255.0f
                                               alpha: 1.000f]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 20)];
    [header addSubview:lbl];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont fontWithName:@"Avenir Book" size:(21.0f)]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setText:[self.sectionTitles objectAtIndex:section]];
    return header;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.sectionTitles indexOfObject:title];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InventoryCell *cell = (InventoryCell *)
        [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InventoryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [self.tblDict objectForKey:sectionTitle];
    NSString *ingredient = [sectionAnimals objectAtIndex:indexPath.row];
    cell.cellName.text = ingredient;
    cell.backgroundColor = [UIColor clearColor];
    
    

    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(UIStoryboardSegue *)segue;
{
    
}

- (IBAction)save:(UIStoryboardSegue *)segue;
{
    {
        EditInventory *editInventoryVC = segue.sourceViewController;
        NSString *firstLetter = [editInventoryVC.ingredient substringToIndex:1];
        if ([self.tblDict objectForKey:firstLetter] == nil)
            {
                NSArray *array = [NSArray arrayWithObjects:(editInventoryVC.ingredient),nil];
                [self.tblDict setObject:array forKey:firstLetter];
                self.sectionTitles = [[self.tblDict allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            }
        else
        {
            NSMutableArray *array2 = [[NSMutableArray alloc] init];
            NSArray *array = [self.tblDict objectForKey:firstLetter];
            array2 = [array mutableCopy];
            [array2 addObject:editInventoryVC.ingredient];
            [self.tblDict setObject:(array2) forKey:(firstLetter)];
            
            
        }
        
        [self.tableView reloadData];
        
    }
}

- (IBAction)tapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)tapAddItem:(id)sender {
    [self performSegueWithIdentifier:@"inventory-edit" sender:self];
}


@end
