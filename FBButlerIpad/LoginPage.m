//
//  LoginPage.m
//  FBButlerIpad
//
//  Created by Mackenzie Hale on 11/26/14.
//  Copyright (c) 2014 Hung Vo. All rights reserved.
//

#import "LoginPage.h"

@interface LoginPage ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginPage

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
    
    self.navigationItem.title = @"J.W. Marriott Menu Butler Login";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapLogin:(id)sender {
    [self performSegueWithIdentifier:@"login-restaurants" sender:self];
}




@end
