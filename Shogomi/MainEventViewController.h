//
//  ViewController.h
//  Shogomi
//
//  Created by Peter Kamm on 3/28/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainEventViewController : UIViewController<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>{
}

@property(strong,nonatomic) CLLocationManager* locationManager;
@property(strong,nonatomic) NSMutableArray *eventsArray;
@property (weak, nonatomic) IBOutlet UITableView *eventTableView;


@property (strong, nonatomic) NSDateFormatter *eventDateFormatter;


-(void)getTicketsWithURL:(NSString*)urlString;

@end
