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
    self.ingredients = [IngredientNetworking2  allIngredForRest:self.restaurant];
    
    for (Ingredient *ingredient in self.ingredients)
    {
        NSString *firstLetter = [ingredient.name substringWithRange:NSMakeRange(0,1)];
        NSMutableArray *array = [self.tblDict objectForKey:firstLetter];
        if(array ==nil)
        {
            array =[NSMutableArray array];
            [self.tblDict setObject:array forKey:firstLetter];
        }
        [array addObject:ingredient];
        
    }
    
    
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
    
    UISwitch *switchController = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    cell.accessoryView = switchController;
    
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [self.tblDict objectForKey:sectionTitle];
    Ingredient *ingredient = [sectionAnimals objectAtIndex:indexPath.row];
    if(ingredient.inStock == TRUE)
    {
    [switchController setOn:YES animated:NO];
        switchController.on = YES;
    }
    else
    {
        [switchController setOn:NO animated:YES];
        switchController.on = NO;
    }
    
    
    [switchController addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    cell.cellName.text = ingredient.name;
    cell.backgroundColor = [UIColor clearColor];
    
    

    return cell;
}

- (void) switchChanged:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    NSIndexPath *index=[self.tableView indexPathForCell:cell];
    NSString *sectionTitle = [self.sectionTitles objectAtIndex:index.section];
    NSArray *sectionAnimals = [self.tblDict objectForKey:sectionTitle];
    Ingredient *ingredient = [sectionAnimals objectAtIndex:index.row];
    
    
    if (ingredient.inStock ==true)
    {
        ingredient.inStock = false;
        [IngredientNetworking2 saveIngredient:ingredient];
        
    }
    else
    {
        ingredient.inStock = true;
        [IngredientNetworking2 saveIngredient:ingredient];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)save:(UIStoryboardSegue *)segue;
{
    {
        
        
        [self.tableView reloadData];
        
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue;
{
    
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.index = indexPath;
    [self performSegueWithIdentifier:@"inventory-edit" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"inventory-edit"])
    {
        if(self.index != nil)
        {
            EditInventory *sub = segue.destinationViewController;
            NSIndexPath *selectedIndex= [self.tableView indexPathForSelectedRow];
            NSString *sectionTitle = [self.sectionTitles objectAtIndex:selectedIndex.section];
            NSArray *sectionItems = [self.tblDict objectForKey:sectionTitle];
            Ingredient *item = [sectionItems objectAtIndex:selectedIndex.row];
            
            sub.ingredientToEdit = item;
            sub.ingredient = item.name;
            
            
            
        }
        else
        {
            EditInventory *sub = segue.destinationViewController;
            Ingredient *item = [[Ingredient alloc] init];
            
            sub.ingredientToEdit = item;
            
        }
    }
 
    
}

- (IBAction)tapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)tapAddItem:(id)sender {
    [self performSegueWithIdentifier:@"inventory-edit" sender:self];
}


@end
