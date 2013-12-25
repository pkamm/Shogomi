//
//  Event.h
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Performer;
@class Venue;

@interface Event : NSObject

@property(strong, nonatomic)NSString* title;
@property(strong, nonatomic)NSString* shortTitle;
@property(strong, nonatomic)NSString* url;
@property(strong, nonatomic)NSString* eventId;
@property(strong, nonatomic)NSDate* time;
@property(strong, nonatomic)NSMutableArray* performerArray;
@property(strong, nonatomic)NSString* performerName;
@property(strong, nonatomic)Venue* venue;
@property(assign, nonatomic)float score;
@property(strong, nonatomic)NSDictionary* stats;
@property (assign, nonatomic) BOOL isExpanded;


+(Event*)eventFromJSON:(id)json searchArtistSlug:(NSString*)searchArtistSlug;



@end
