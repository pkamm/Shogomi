//
//  Performer.m
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import "Performer.h"

@implementation Performer

+(Performer*)performerFromJSON:(id)json{
    Performer* performer = [Performer new];
    
    [performer setPerformerId:[json objectForKey:@"id"]];
    [performer setLargeImage:[json objectForKey:@"image"]];
    [performer setSmallImage:[[json objectForKey:@"images"] objectForKey:@"small"]];
    [performer setMongoImage:[[json objectForKey:@"images"] objectForKey:@"mongo"]];
    [performer setBannerImage:[[json objectForKey:@"images"] objectForKey:@"banner"]];
    [performer setHugeImage:[[json objectForKey:@"images"] objectForKey:@"huge"]];
    [performer setName:[json objectForKey:@"name"]];
    [performer setShortName:[json objectForKey:@"short_name"]];
    [performer setUrl:[json objectForKey:@"url"]];
    [performer setIsSearchArtist:NO];

    return performer;
}

/*
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
               ]
*/

@end
