//
//  EditInventory.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/15/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "EditInventory.h"


@interface EditInventory ()

@end

@implementation EditInventory

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
    
    self.navigationItem.title = @"Edit Ingredient";

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tapCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveSegue"])
    {
        self.ingredient = self.name.text;
        self.ingredient = [self.ingredient capitalizedString];
    } 
}




@end
