//
//  IntroViewController.m
//  Shogomi
//
//  Created by Peter Kamm on 4/8/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "IntroViewController.h"
#import "MainEventViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

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
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startButtonPressed:(id)sender {
    
    MainEventViewController *mainEventController = [[MainEventViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainEventController];
    [[navController navigationBar] setTintColor:[UIColor blackColor]];

    [self presentViewController:navController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
