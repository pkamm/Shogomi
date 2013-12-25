//
//  Venue.h
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

/*
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
 }
 */

+(Venue*)venueFromJSON:(id)json;

@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* url;
@property(nonatomic,strong)NSDictionary* location;
@property(nonatomic,strong)NSString* address;


@end
