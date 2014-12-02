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
