//
//  SettingsViewController.m
//  Shogomi
//
//  Created by Peter Kamm on 4/9/13.
//  Copyright (c) 2013 Smatterbox. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

- (IBAction)sendFeedback:(id)sender {
    Class  mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
            [mailController setSubject:@"User Feedback"];
            [mailController setToRecipients:[NSArray arrayWithObjects:@"shogomi_support@gmail.com", nil]];
            [mailController setMessageBody:@"Thanks for using Shogomi!  Please let us know how we can improve your experience:" isHTML:YES];
            mailController.mailComposeDelegate = self;
            [self presentViewController:mailController animated:YES completion:nil];
        }else{
            [self launchMailAppOnDevice];
        }
    }else{
        [self launchMailAppOnDevice];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)launchMailAppOnDevice
{
    NSString *recipients = @"shogomi_support@gmail.com?&subject=Shogomi Feedback";
    NSString *body = @"&body=Thanks for using Shogomi!  Please let us know how we can improve your experience:";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
