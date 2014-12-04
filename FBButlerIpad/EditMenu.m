//
//  EditMenu.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "EditMenu.h"

@interface EditMenu ()

@property (weak, nonatomic) IBOutlet UITableView *tableViewI;

@end

@implementation EditMenu

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
    self.navigationItem.title = @"Edit Menu Item";
    
    self.name.text = self.menuName;
    self.description.text = self.menuDescription;
    self.price.text = self.menuPrice;
    self.image.text = self.imageName;
    self.category.text = self.restCategory.name;
    self.menuIngredients = [[NSMutableArray alloc] init];
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.ingredients.count;
    
    
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
    
    [lbl setText:@"Ingredients"];
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        MenuIngredientCell *cell = (MenuIngredientCell *)
        [tableView dequeueReusableCellWithIdentifier:@"CellsI"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuIngredientCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    
        Ingredient *ingredient = [self.ingredients objectAtIndex:indexPath.row];
        NSString *name = ingredient.name;
        cell.cellName.text = name;
        
    
    
        return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    {
        [[self.tableViewI cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        if(![self.menuIngredients containsObject:[self.ingredients objectAtIndex:indexPath.row]])
        {
            [self.menuIngredients addObject:[self.ingredients objectAtIndex:indexPath.row]];
            
            
        }
        
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"])
    {
        self.item.name = self.name.text;
        for (FoodCategory *category in self.categories)
        {
            if(category.name == self.category.text)
            {
                self.item.category = category;
            }
            else
            {
                FoodCategory *catToAdd = [[FoodCategory alloc] init];
                catToAdd.name = self.category.text;
                [FoodCategoryNetworking saveCategory:catToAdd];
            }
        }
        self.item.price = self.price.text;
        self.item.pictureURL = [[NSURL alloc] initWithString:self.image.text];
        self.item.description = self.description.text;
        self.item.ingredients = self.menuIngredients;
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
