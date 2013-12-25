//
//  EventDetailsViewController.m
//  Shogomi
//
//  Created by Peter Kamm on 4/7/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "AFNetworking.h"
#import "Performer.h"
#import "Venue.h"
#import <EventKit/EventKit.h>

@interface EventDetailsViewController ()

@end

@implementation EventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithEvent:(Event*)event
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.event = event;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    titleLabel.text = [self.event performerName];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.navigationItem.titleView = titleLabel;
    

    
    //if ([[self.event performer] image] && [[[self.event performer] image] isMemberOfClass:[NSNull class]] ) {
    [self.largePerformerImageView setImageWithURL:[NSURL URLWithString:[(Performer*)[[self.event performerArray] objectAtIndex:0] largeImage]]];
    [self.eventTitleLabel setText:[self.event title]];
    //}
    [self.venueLabel setText:[[self.event venue] name]];
    
}

- (IBAction)getTicketsButtonPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [self.event url]]];
}

- (IBAction)addToCalendarButtonPressed:(id)sender {
    
    EKEventStore *eventStore=[[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        EKEvent *addEvent = [EKEvent eventWithEventStore:eventStore];
        addEvent.title = [self.event title];
        addEvent.location = [[self.event venue] name];
        addEvent.notes = [NSString stringWithFormat:@"Buy tickets at %@",[self.event url]];
        addEvent.URL= [NSURL URLWithString:[self.event url]];
        addEvent.startDate=[self.event time];
        addEvent.endDate=[addEvent.startDate dateByAddingTimeInterval:60*60*4];
        [addEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
        addEvent.alarms=[NSArray arrayWithObject:[EKAlarm alarmWithAbsoluteDate:addEvent.startDate]];
        [eventStore saveEvent:addEvent span:EKSpanThisEvent error:nil];
    }];
    
}


- (IBAction)backButtonPressed:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
