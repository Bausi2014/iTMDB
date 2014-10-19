//
//  TMDBPromisedTVSeries.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBPromisedMovie.m
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import "TMDBPromisedTVSeries.h"
#import "TMDBImage.h"

#import "NSDictionary+extractValue.h"

@implementation TMDBPromisedTVSeries
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
     
     @property NSString* backdrop_path;
     @property NSDate* first_air_date;
     @property NSNumber* id;
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
 
}*/

+ (TMDBPromisedTVSeries*)promisedTVSeriesFromDictionary:(NSDictionary*)tvSeries withContext:(TMDB*)context {
    return [[TMDBPromisedTVSeries alloc] initWithContentsOfDictionary:tvSeries fromContext:context];
}

- (id)initWithContentsOfDictionary:(NSDictionary*)tvSeries fromContext:(TMDB*)context {
    if (self = [super init]) {
        
        NSLog(@"PromisedTV : %@", tvSeries);
        
        // @property TMDB *context;
        _context = context;
        
        // @property NSDictionary *rawData;
        _rawData = tvSeries;
        
        // @property NSString* backdrop_path;
        _backdrop_path = [tvSeries extractValueforKey:@"backdrop_path" ifClass:[NSString class]];
        // @property NSDate* first_air_date;
        _first_air_date = [tvSeries extractValueforKey:@"first_air_date" ifClass:[NSDate class]];
        // @property NSNumber* id;
        _identifier = [tvSeries extractValueforKey:@"id" ifClass:[NSNumber class]];
        // @property NSString* name;
        _name = [tvSeries extractValueforKey:@"name" ifClass:[NSString class]];
        // @property NSArray* origin_country;
        _origin_country = [tvSeries extractValueforKey:@"origin_country" ifClass:[NSArray class]];
        // @property NSString* original_name;
        _original_name = [tvSeries extractValueforKey:@"original_name" ifClass:[NSString class]];
        // @property NSNumber *popularity;
        _popularity = [tvSeries extractValueforKey:@"popularity" ifClass:[NSNumber class]];
        // @property NSString *poster_path;
        _poster_path = [tvSeries extractValueforKey:@"poster_path" ifClass:[NSString class]];
        // @property NSNumber *vote_average;
        _vote_average = [tvSeries extractValueforKey:@"vote_average" ifClass:[NSNumber class]];
        // @property NSNumber *vote_count;
        _vote_count = [tvSeries extractValueforKey:@"vote_count" ifClass:[NSNumber class]];
        
        // @property NSImage *loadedPoster;
        // @property TMDBImage *loadingPoster;
    }
    return self;
}

- (void)loadPoster {
    if (self.poster_path != nil || ![self.poster_path isMemberOfClass:[NSNull class]]) {
        [self performSelectorInBackground:@selector(loadPosterInBackgroundThread) withObject:nil];
    }
}

- (void)loadPosterInBackgroundThread {
    @autoreleasepool {
        if ([self.poster_path respondsToSelector:@selector(length)]) {
            self.loadingPoster = [[TMDBImage alloc] initWithAddress:[NSURL URLWithString:self.poster_path] context:self.context delegate:self andContextInfo:nil];
        }
    }
}

- (void)tmdbImageInContext:(TMDB*)context didFinishLoading:(NSImage*)aImage {
    _loadingPoster = nil;
    self.loadedPoster = aImage;
}

- (void)tvSeries {
    [self.context tvSeriesWithID:[[self identifier] intValue]];
}

@end
