//
//  TMDBPromisedTVSeason.h
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

@interface TMDBPromisedTVSeason : NSObject <TMDBImageDelegate>

/**
 ************************************************
 *               PromisedTVSeason               *
 ************************************************
 *    Type    *   Variable    *      Key        *
 ************************************************
 *  NSDate*       air_date 	       air_date     *
 *  NSNumber*    identifier          id         *
 *  NSString*    poster_path   	 poster_path    *
 *  NSNumber*   season_number    season_number  *
 ************************************************
 */
 
@property TMDB *context;
@property NSDictionary *rawData;

@property NSNumber *parentID;
@property NSDate *air_date;
@property NSNumber *identifier;
@property NSString *poster_path;
@property NSNumber *season_number;

@property NSImage *loadedPoster;
@property TMDBImage *loadingPoster;

+ (TMDBPromisedTVSeason*)promisedTVSeasonFromDictionary:(NSDictionary*)tvSeason withContext:(TMDB*)context;
- (id)initWithContentsOfDictionary:(NSDictionary*)tvSeason fromContext:(TMDB*)context;

- (void)loadPoster;
- (void)tvSeason;

@end
