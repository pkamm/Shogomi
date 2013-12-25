//
//  EventDetailsViewController.h
//  Shogomi
//
//  Created by Peter Kamm on 4/7/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *largePerformerImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *getTicketsButton;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;

@property (strong, atomic) Event *event;

- (id)initWithEvent:(Event*)event;


@end
