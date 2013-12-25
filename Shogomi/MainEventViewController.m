//
//  ViewController.m
//  Shogomi
//
//  Created by Peter Kamm on 3/28/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "MainEventViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AFNetworking.h"
#import "Event.h"
#import "EventCell.h"
#import "EventDetailsViewController.h"
#import "SettingsViewController.h"
#import "GetTicketsViewController.h"


@interface MainEventViewController ()

@end

@implementation MainEventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    titleLabel.text = @"Shogomi";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.navigationItem.titleView = titleLabel;
    
    //UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
//    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIButtonTypeInfoLight target:self action:@selector(something)];
    
    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingsButton setImage:[UIImage imageNamed:@"TabGearsIcon"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settingsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton setFrame:CGRectMake(0, 0, 26, 44)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    self.eventDateFormatter = [[NSDateFormatter alloc] init];
    [self.eventDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.eventDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    //[self.eventDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    self.eventsArray = [[NSMutableArray alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
    
//    [self createHeaderView];
}


-(void)runEventQuery{
    
    double latitude = [[self.locationManager location] coordinate].latitude;
    double longitude = [[self.locationManager location] coordinate].longitude;
    
    // Specify a media query; this one matches the entire iPod library because it
    // does not contain a media property predicate
    MPMediaQuery *everything = [MPMediaQuery artistsQuery];
    [everything setGroupingType: MPMediaGroupingAlbumArtist];
    
    // Obtain the media item collections from the query
    NSArray *collections = [everything collections];
    NSSet *uniqueArtists = [NSSet setWithArray:collections];
    
    for (MPMediaItemCollection *mediaCollection in uniqueArtists){
        
        NSLog(@"%@",[[mediaCollection representativeItem] valueForProperty:MPMediaItemPropertyArtist]);
        
        NSString *performerSlug = [[[[mediaCollection representativeItem] valueForProperty:MPMediaItemPropertyArtist] stringByReplacingOccurrencesOfString:@" " withString:@"-"] lowercaseString];
        
        NSString *eventURL = [NSString stringWithFormat:@"http://api.seatgeek.com/2/events?performers.slug=%@&lat=%f&lon=%f&aid=10375", performerSlug, latitude, longitude];
        NSLog(@"request: %@", eventURL);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:eventURL]];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            if ([JSON objectForKey:@"events"] && [[JSON objectForKey:@"events"] count] > 0) {
                for (id eventJSON in [JSON objectForKey:@"events"]) {
                    
                    Event *newEvent = [Event eventFromJSON:eventJSON searchArtistSlug:performerSlug];
                    [newEvent setPerformerName:[[mediaCollection representativeItem] valueForProperty:MPMediaItemPropertyArtist] ];
                    
                    if ([self.eventsArray count] == 0) {
                        [self.eventsArray addObject:newEvent];
                        [self updateRow:0];
                        break;
                    }
                    for (int i = 0; i < [self.eventsArray count]; i++) {
                        
                        if ([[newEvent time] earlierDate:[[self.eventsArray objectAtIndex:i] time]] == [newEvent time]){
                            [self.eventsArray insertObject:newEvent atIndex:i];
                            [self updateRow:i];
                            break;
                        }
                        else if (i == [self.eventsArray count]-1){
                            [self.eventsArray addObject:newEvent];
                            [self updateRow:i];
                            break;
                        }
                    }
                    NSLog(@"%@",JSON);
                }
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
        }];
        
        [operation start];
    }
}

-(void)updateRow:(int)row{
    [self.eventTableView beginUpdates];
    [self.eventTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.eventTableView endUpdates];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
        case kCLAuthorizationStatusAuthorized:
            [self runEventQuery];
            break;
        case kCLAuthorizationStatusDenied:
            
            break;
        case kCLAuthorizationStatusNotDetermined:
            
            break;
        case kCLAuthorizationStatusRestricted:
            
            break;
            
        default:
            break;
    }
}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.eventsArray objectAtIndex:indexPath.row] isExpanded]) {
        return 300;
    }else{
        return 128;
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventCell *cell = [EventCell eventCellWithEvent:[self.eventsArray objectAtIndex:indexPath.row] dateFormatter:self.eventDateFormatter];
    [cell setDelegate:self];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*  EventDetailsViewController *eventDetails = [[EventDetailsViewController alloc] initWithEvent:[self.eventsArray objectAtIndex:indexPath.row]];
     [self.navigationController pushViewController:eventDetails animated:YES];
     */
    
    [[self.eventsArray objectAtIndex:indexPath.row] setIsExpanded:![[self.eventsArray objectAtIndex:indexPath.row] isExpanded]];
    
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)createHeaderView{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 42)];
    [headerView setBackgroundColor:[UIColor blackColor]];
    UIButton *seatGeekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [seatGeekButton setBackgroundImage:[UIImage imageNamed:@"102x31"] forState:UIControlStateNormal];
    [seatGeekButton setFrame:CGRectMake(4, 20, 80, 120)];
    [headerView addSubview:headerView];

    [self.eventTableView setTableHeaderView:headerView];
}

-(IBAction)seatGeekButtonPressed:(id)sender{
    
}

-(IBAction)settingsButtonPressed:(id)sender{
    SettingsViewController *settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:settingsView animated:YES];
}

-(void)getTicketsWithURL:(NSString*)urlString{
    GetTicketsViewController *tixView = [[GetTicketsViewController alloc] initWithNibName:@"GetTicketsViewController" bundle:[NSBundle mainBundle]];
    [tixView setUrl:urlString];
    [self.navigationController pushViewController:tixView animated:YES];
    
}


-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventsArray count];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
