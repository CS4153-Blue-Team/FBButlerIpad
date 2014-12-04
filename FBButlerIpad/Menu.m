//
//  Menu.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "Menu.h"

@interface Menu ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Menu

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
    self.navigationItem.title = @"Menu Item Inventory";
    
    NSLog(@"These are the sections: %@", self.sectionTitles);
    NSLog(@"This is the dictionary: %@", self.tblDict);
	
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  [self.sectionTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    FoodCategory *category = [self.sectionTitles objectAtIndex:section];
    NSString *sectionTitle = category.name;
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
    FoodCategory *category = [self.sectionTitles objectAtIndex:section];
    NSString *sectionTitle = category.name;
    [lbl setText:sectionTitle];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)
    [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    FoodCategory *category = [self.sectionTitles objectAtIndex:indexPath.section];
    NSString *sectionTitle = category.name;
    NSArray *sectionAnimals = [self.tblDict objectForKey:sectionTitle];
    MenuItem *item = [sectionAnimals objectAtIndex:indexPath.row];
    NSString *name = item.name;
    cell.cellName.text = name;
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    self.index = indexPath;
    [self performSegueWithIdentifier:@"menu-editMenu" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(self.index != nil)
    {
        EditMenu *sub = segue.destinationViewController;
        NSIndexPath *selectedIndex= [self.tableView indexPathForSelectedRow];
        FoodCategory *category = [self.sectionTitles objectAtIndex:selectedIndex.section];
        NSString *sectionTitle = category.name;
        NSArray *sectionItems = [self.tblDict objectForKey:sectionTitle];
        MenuItem *item = [sectionItems objectAtIndex:selectedIndex.row];
        
        
        sub.item = item;
        
        sub.menuName = item.name;
        sub.menuDescription = item.description;
        sub.menuPrice = item.price;
        
        NSString *image =[item.pictureURL absoluteString];
        sub.imageName = image;
        self.ingredients = [IngredientNetworking2 allIngredForRest:(self.restaurant) ];
        sub.ingredients = self.ingredients;
        sub.menuIngredients = [MenuItemNetworking retIngredientsFor:item];
        sub.restaurant = self.restaurant;
        sub.restCategory = category;
        
        
    }
    
}

- (IBAction)save:(UIStoryboardSegue *)segue;
{
    {
        EditMenu *editMenuVC = segue.sourceViewController;
        
        
            
            
    
        
        [self.tableView reloadData];
        
    }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue;
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapLogout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)tapAdd:(id)sender {
    [self performSegueWithIdentifier:@"menu-editMenu" sender:self];
}

@end
