//
//  TMDBTVSeries.h
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

@interface TMDBTVSeries : NSObject <TMDBRequestDelegate>

/*
 NSString* backdrop_path
 NSArray* created_by
    NSDictionary* 0
        NSNumber* id
        NSString* name
        NSString* profile_path
 NSArray* episode_run_time
    NSNumber* 25
 NSDate* first_air_date
 NSArray* genres
    NSDictionary* 0
        NSNumber* id
        NSString* name
 NSString* homepage
 NSNumber* id
 NSDictionary* images
    NSArray* backdrops / posters
        NSDictionary* 0
            NSNumber* aspect_ratio
            NSString* file_path
            NSNumber* height
            NSString* iso_639_1
            NSNumber* vote_average
            NSNumber* vote_count
            NSNumber* width
 NSNumber* in_production
 NSDictionary* keywords
    NSArray* results
        NSDictionary* 0
            NSNumber* id
            NSString* name
 NSArray* languages
    NSString* en
 NSDate* last_air_date
 NSString* name
 NSArray* networks
    NSDictionary* 0
        NSNumber* id
        NSString* name
 NSNumber* number_of_episodes
 NSNumber* number_of_seasons
 NSArray* origin_country
    NSString* US
 NSString* original_name
 NSString* overview
 NSNumber* popularity
 NSString* poster_path
 NSArray* production_companies
    NSDictionary* 0
        NSNumber* id
        NSString* name
 NSArray* seasons
    NSDictionary* 0
        NSString* air_date
        NSNumber* id
        NSString* poster_path
        NSNumber* season_number
 NSString* status
 NSNumber* vote_average
 NSNumber* vote_count
 */

@property TMDB *context;
@property TMDBRequest *request;

@property NSDictionary *rawResults;

@property NSString *backdrop_path;
@property NSArray *created_by;
@property NSNumber *episode_run_time;
@property NSDate *first_air_date;
@property NSArray *genres;
@property NSURL *homepage;
@property NSNumber *identifier;
@property NSArray *images;
@property NSNumber *in_production;
@property NSArray *keywords;
@property NSArray *languages;
@property NSDate *last_air_date;
@property NSString *name;
@property NSArray *networks;
@property NSNumber *number_of_episodes;
@property NSNumber *number_of_seasons;
@property NSArray *origin_country;
@property NSString *original_name;
@property NSString *overview;
@property NSNumber *popularity;
@property NSString *poster_path;
@property NSArray *seasons;
@property NSArray *production_companies;
@property NSString *status;
@property NSNumber *vote_average;
@property NSNumber *vote_count;

+ (TMDBTVSeries *)tvSeriesWithID:(NSInteger)anID context:(TMDB *)context;
- (id)initWithID:(NSInteger)anID context:(TMDB *)context;

@end