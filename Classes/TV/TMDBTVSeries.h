//
//  TMDBTVSeries.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derrived from TMDBMovie.h
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TMDB;

#import "TMDBRequest.h"
#import "TMDBRequestDelegate.h"

@interface TMDBTVSeries : NSObject <TMDBRequestDelegate> {
/*@protected
	TMDB			*_context;
	TMDBRequest		*_request;
    
    NSDictionary	*_rawResults;
    
    NSString		*_backdrop_path;
    NSArray         *_created_by;
    NSUInteger      _episode_run_time;
    NSString		*_first_air_date;
    NSArray         *_genres;
    NSURL           *_homepage;
    NSInteger		_id;
    NSArray         *_images;
    NSString		*_in_production;
    NSArray         *_keywords;
    NSArray         *_languages;
    NSString		*_last_air_date;
    NSString		*_name;
    NSArray         *_networks;
    NSInteger		_number_of_episodes;
    NSInteger		_number_of_seasons;
    NSArray         *_origin_country;
    NSString		*_original_name;
    NSString		*_overview;
    NSInteger		_popularity;
    NSString		*_poster_path;
    NSArray         *_production_companies;
    NSArray         *_seasons;
    NSString		*_status;
    NSInteger		_vote_average;
    NSInteger		_vote_count;
    */
    BOOL			isSearchingOnly;
}

+ (TMDBTVSeries *)tvSeriesWithID:(NSInteger)anID context:(TMDB *)context;
- (id)initWithID:(NSInteger)anID context:(TMDB *)context;

@property (nonatomic, strong, readonly) TMDB			*context;
@property (nonatomic, readwrite) TMDBRequest            *request;
@property (nonatomic, strong, readonly) NSDictionary	*rawResults;

@property (nonatomic, strong, readonly) NSString		*backdrop_path;
@property (nonatomic, strong, readonly) NSArray         *created_by;
@property (nonatomic, strong, readonly) NSNumber		*episode_run_time;
@property (nonatomic, strong, readonly) NSDate          *first_air_date;

@property (nonatomic, strong, readonly) NSArray         *genres;
@property (nonatomic, strong, readonly) NSURL			*homepage;
@property (nonatomic, strong, readonly) NSNumber		*id;
@property (nonatomic, strong, readonly) NSArray         *images;
@property (nonatomic, strong, readonly) NSNumber		*in_production;
@property (nonatomic, strong, readonly) NSArray			*keywords;
@property (nonatomic, strong, readonly) NSArray         *languages;
@property (nonatomic, strong, readonly) NSDate          *last_air_date;
@property (nonatomic, strong, readonly) NSString		*name;
@property (nonatomic, strong, readonly) NSArray         *networks;
@property (nonatomic, strong, readonly) NSNumber		*number_of_episodes;
@property (nonatomic, strong, readonly) NSNumber		*number_of_seasons;
@property (nonatomic, strong, readonly) NSArray         *origin_country;
@property (nonatomic, strong, readonly) NSString		*original_name;
@property (nonatomic, strong, readonly) NSString		*overview;
@property (nonatomic, strong, readonly) NSNumber		*popularity;
@property (nonatomic, strong, readonly) NSString		*poster_path;
@property (nonatomic, strong, readonly) NSArray         *production_companies;
@property (nonatomic, strong, readonly) NSArray         *seasons;
@property (nonatomic, strong, readonly) NSString		*status;
@property (nonatomic, strong, readonly) NSNumber		*vote_average;
@property (nonatomic, strong, readonly) NSNumber		*vote_count;

@property (nonatomic, readwrite) BOOL loaded;

@end