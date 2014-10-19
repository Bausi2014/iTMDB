//
//  TMDBTVSeason.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBMovie.h
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBRequestDelegate.h"

@class TMDB;

@interface TMDBTVSeason : NSObject <TMDBRequestDelegate>
/*
 NSDate* air_date" = "1989-12-17";
 NSArray* episodes
    NSDictionary* 0
        ...
 NSNumber* id = 3582;
 NSDictionary* images
	NSArray* posters
        NSDictionary* 0
            NSNumber* aspect_ratio" = "0.692041522491349";
            NSString* file_path" = "/o6wvnWuUKW1g2bLs2gmI2ObMYJG.jpg";
            NSNumber* height = 578;
            NSString* id = 5256c24819c2956ff6005698;
            NSString* iso_639_1" = en;
            NSNumber* vote_average" = 0;
            NSNumber* vote_count" = 0;
            NSNumber* width = 400;
 NSString* name = "Season 1";
 NSString* overview = "The Simpsons' first season ...";
 NSNumber* season_number" = 1;
 */

@property TMDB *context;
@property TMDBRequest *request;

@property NSDictionary *rawResults;

@property NSDate *air_date;
@property NSArray *episodes;
@property NSNumber *identifier;
@property NSArray *images;
@property NSString *name;
@property NSString *overview;
@property NSNumber *season_number;

+ (TMDBTVSeason *)tvSeasonWithID:(NSInteger)anID andSeasonNumber:(NSInteger)aSeason context:(TMDB *)context;

- (id)initWithID:(NSInteger)anID andSeasonNumber:(NSInteger)aSeason context:(TMDB *)context;

@end