//
//  Performer.h
//  Shogomi
//
//  Created by Peter Kamm on 4/5/13.
//  Copyright (c) 2013 Peter Kamm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Performer : NSObject

@property(nonatomic,strong)NSString* performerId;
@property(nonatomic,strong)NSString* largeImage;
@property(nonatomic,strong)NSString* smallImage;
@property(nonatomic,strong)NSString* mongoImage;
@property(nonatomic,strong)NSString* bannerImage;
@property(nonatomic,strong)NSString* hugeImage;
@property(nonatomic,strong)NSString* name;
@property(nonatomic,strong)NSString* shortName;
@property(nonatomic,strong)NSString* url;
@property(nonatomic,strong)NSDictionary* images;
@property(nonatomic,assign)BOOL isSearchArtist;


+(Performer*)performerFromJSON:(id)json;

@end
