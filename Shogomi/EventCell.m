//
//  EventCell.m
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "EventCell.h"
#import "Event.h"
#import "Venue.h"
#import "Performer.h"
#import "AFNetworking.h"
#import "MainEventViewController.h"
#import <EventKit/EventKit.h>


@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+(EventCell*)eventCellWithEvent:(Event*)event dateFormatter:(NSDateFormatter*)dateFormatter{
    
    //EventCell *eventCell = [[EventCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    EventCell *eventCell = nil;
    
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];

    eventCell = [topLevelObjects objectAtIndex:0];
    
    [[eventCell titleLabel] setText:[event performerName]];
    [[eventCell eventTitle] setText:[event title]];
    [[eventCell dateLabel] setText:[dateFormatter stringFromDate:[event time]]];
    [[eventCell venueLabel] setText:[NSString stringWithFormat:@"Venue: %@",[[event venue] name]]];
    
    for (Performer *performer in [event performerArray]) {
        if ([performer isSearchArtist]) {
            NSString *imageURL = nil;
            if ([performer bannerImage] && ![[performer bannerImage] isKindOfClass:[NSNull class]]) {
                imageURL = [performer bannerImage];
            }
            else if ([performer hugeImage] && ![[performer hugeImage] isKindOfClass:[NSNull class]]) {
                imageURL = [performer hugeImage];
            }
            else if ([performer largeImage] && ![[performer largeImage] isKindOfClass:[NSNull class]]) {
                imageURL = [performer largeImage];
            }
            if (imageURL) {
                [[eventCell performerImage] setImageWithURL:[NSURL URLWithString:[imageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                break;
            }
        }
    }
    
    eventCell.event = event;
    [eventCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return eventCell;
}

- (IBAction)getTicketsButtonPressed:(id)sender {
    [self.delegate getTicketsWithURL:[self.event url]];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: [self.event url]]];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
