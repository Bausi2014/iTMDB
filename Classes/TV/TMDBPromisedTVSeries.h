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
/*{
    {
        "backdrop_path" = "/JYvwAAI2UOqgQSlpjuVfDA5Fy0.jpg";
        "first_air_date" = "2000-01-09";
        id = 2004;
        name = "Malcolm in the Middle";
        "origin_country" =     (
                                US
                                );
        "original_name" = "Malcolm in the Middle";
        popularity = "0.91503238334424";
        "poster_path" = "/ozNO2Q5OK3mIItc8HZoXAvfAobb.jpg";
        "vote_average" = "8.4";
        "vote_count" = 8;
    }
}*/

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
