//
//  Event.m
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "Event.h"
#import "Performer.h"
#import "Venue.h"

@implementation Event

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code
        self.performerArray = [NSMutableArray array];
        self.isExpanded = NO;
    }
    return self;
}

+(Event*)eventFromJSON:(id)json searchArtistSlug:(NSString*)searchArtistSlug{
    Event* event = [Event new];
    [event setTitle:[json objectForKey:@"title"]];
    [event setUrl:[json objectForKey:@"url"]];
    [event setTime:[Event eventDate:[json objectForKey:@"datetime_local"]]];
    [event setShortTitle:[json objectForKey:@"short_title"]];
//    [event setScore:[[json objectForKey:@"score"] floatValue]];
    
    for (id performerJSON in [json objectForKey:@"performers"]){
        Performer *newPerformer = [Performer performerFromJSON:performerJSON];
        if ([[performerJSON objectForKey:@"slug"] isEqualToString:searchArtistSlug]) {
            [newPerformer setIsSearchArtist:YES];
        }
        [[event performerArray] addObject:newPerformer];
    }
    [event setVenue:[Venue venueFromJSON:[json objectForKey:@"venue"]]];
    [event setStats:[json objectForKey:@"stats"]];

    return event;
}


+ (NSDate *)eventDate:(NSString *)dateString {
    if ([dateString isKindOfClass:[NSNull class]]) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"]; // 2011-11-02T06:24:10
    
    return [dateFormatter dateFromString:dateString];
}


/*
"stats": {
"listing_count": 161,
"average_price": 97,
"lowest_price": 62,
"highest_price": 296
},
"title": "Young The Giant with Grouplove",
"url": "http://seatgeek.com/young-the-giant-with-grouplove-tickets/new-york-new-york-terminal-5-2012-03-09/concert/721901/",
"datetime_local": "2012-03-09T19:00:00",
"performers": [
               {
                   "name": "Young The Giant",
                   "short_name": "Young The Giant",
                   "url": "http://seatgeek.com/young-the-giant-tickets/",
                   "image": "http://cdn.seatgeek.com/images/bandshuge/band_8741.jpg",
                   "images": {
                       "large": "http://cdn.seatgeek.com/images/performers/8741/eec61caec82950448b257c5e539147bc/large.jpg",
                       "huge": "http://cdn.seatgeek.com/images/performers/8741/555bce1815140ad65ab0b1066467ae7d/huge.jpg",
                       "small": "http://cdn.seatgeek.com/images/performers/8741/af7a8925e50bb74315337a9450206a39/small.jpg",
                       "medium": "http://cdn.seatgeek.com/images/performers/8741/686f925886504610936135abd240235c/medium.jpg"
                   },
                   "primary": true,
                   "id": 8741,
                   "score": 6404,
                   "type": "band",
                   "slug": "young-the-giant"
               },
               {
                   "name": "Grouplove",
                   "short_name": "Grouplove",
                   "url": "http://seatgeek.com/grouplove-tickets/",
                   "image": null,
                   "images": null,
                   "id": 8987,
                   "score": 4486,
                   "type": "band",
                   "slug": "grouplove"
               }
               ],
"venue": {
    "city": "New York",
    "name": "Terminal 5",
    "extended_address": null,
    "url": "http://seatgeek.com/terminal-5-tickets/",
    "country": "US",
    "state": "NY",
    "score": 149.259,
    "postal_code": "10019",
    "location": {
        "lat": 40.77167,
        "lon": -73.99277
    },
    "address": null,
    "id": 814
},
"short_title": "Young The Giant with Grouplove",
"datetime_utc": "2012-03-10T00:00:00",
"score": 116.977,
"taxonomies": [
               {
                   "parent_id": null,
                   "id": 2000000,
                   "name": "concert"
               }
               ],
"type": "concert",
"id": 721901
}
*/
@end
