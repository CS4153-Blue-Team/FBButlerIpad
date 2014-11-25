//
//  Login.m
//  FBButlerIpad
//
//  Created by Hung Vo on 11/11/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

//Tap a button to go to Menu Guide
- (IBAction)tapCustomer:(id)sender {
    [self performSegueWithIdentifier:@"login-menuguide" sender:self];
}

//Tap a button to go to Menu Butler
- (IBAction)tapEmployee:(id)sender {
    [self performSegueWithIdentifier:@"login-menubutler" sender:self];
}

@end
