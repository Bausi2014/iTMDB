//
//  TMDBPromisedTVSeries.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBPromisedMovie.h
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBImageDelegate.h"

@interface TMDBPromisedTVSeries : NSObject <TMDBImageDelegate>

/**
 ************************************************
 *               PromisedTVSeries               *
 ************************************************
 *    Type    *   Variable    *      Key        *
 ************************************************
 *  NSString* 	backdrop_path 	backdrop_path   *
 *  NSDate* 	first_air_date 	first_air_date  *
 *  NSNumber* 	identifier      id              *
 *  NSString* 	name          	name            *
 *  NSArray * 	origin_country 	origin_country  *
 *  NSString* 	original_name 	original_name   *
 *  NSNumber* 	popularity    	popularity      *
 *  NSString* 	poster_path   	poster_path     *
 *  NSNumber* 	vote_average  	vote_average    *
 *  NSNumber* 	vote_count    	vote_count      *
 ************************************************
 */

@property NSString* backdrop_path;
@property NSDate* first_air_date;
@property NSNumber* identifier;
@property NSString* name;
@property NSArray* origin_country;
@property NSString* original_name;
@property NSNumber *popularity;
@property NSString *poster_path;
@property NSNumber *vote_average;
@property NSNumber *vote_count;

@property NSImage *loadedPoster;
@property TMDBImage *loadingPoster;

@property NSDictionary *rawData;
@property TMDB *context;

+ (TMDBPromisedTVSeries*)promisedTVSeriesFromDictionary:(NSDictionary*)tvSeries withContext:(TMDB*)context;
- (id)initWithContentsOfDictionary:(NSDictionary*)tvSeries fromContext:(TMDB*)context;

- (void)loadPoster;
- (void)tvSeries;

@end
