//
//  EventCell.h
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Event;

@interface EventCell : UITableViewCell

@property (weak, nonatomic) id delegate;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UIImageView *performerImage;
@property (strong, nonatomic) Event* event;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;


+(EventCell*)eventCellWithEvent:(Event*)event dateFormatter:(NSDateFormatter*)dateFormatter;


@end
