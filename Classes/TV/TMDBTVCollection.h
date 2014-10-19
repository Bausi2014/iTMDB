//
//  TMDBTVCollection.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBMovieCollection.h
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBRequestDelegate.h"

@class TMDB;

@interface TMDBTVCollection : NSObject <TMDBRequestDelegate>

/*
 //NSNumber *page": 1,
 //NSArray *results
 //	NSDictionary* 0
 //		NSString * backdrop_path": "/bzoZjhbpriBT2N5kwgK0weUfVOX.jpg",
 //		NSNumber * id": 1396,
 //		NSString * original_name": "Breaking Bad",
 //		NSString * first_air_date": "2008-01-19",
 //		NSArray * origin_country
 //			NSString * US"
 //		NSString * poster_path": "/4yMXf3DW6oCL0lVPZaZM2GypgwE.jpg",
 //		NSNumber * popularity": 3.51233746888476,
 //		NSString * name": "Breaking Bad",
 //		NSNumber * vote_average": 9,
 //		NSNumber * vote_count": 118
 //NSNumber *total_pages": 1,
 //NSNumber *total_results": 1
 */

@property TMDB *context;
@property TMDBRequest *request;
@property NSArray *rawResults;
@property NSString *name;

@property NSNumber* page;
@property NSMutableArray *results;
@property NSNumber* total_pages;
@property NSNumber* total_results;

+ (TMDBTVCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context;
- (id)initWithName:(NSString*)aName andContext:(TMDB*)aContext;

@end
