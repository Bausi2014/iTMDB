//
//  TMDBPromisedTVSeason.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBPromisedMovie.m
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import "TMDBPromisedTVSeason.h"
#import "TMDBImage.h"

#import "NSDictionary+extractValue.h"

@implementation TMDBPromisedTVSeason

+ (TMDBPromisedTVSeason*)promisedTVSeasonFromDictionary:(NSDictionary*)tvSeason withContext:(TMDB*)context {
    return [[TMDBPromisedTVSeason alloc] initWithContentsOfDictionary:tvSeason fromContext:context];
}

- (id)initWithContentsOfDictionary:(NSDictionary*)tvSeason fromContext:(TMDB*)context {
    self = [super init];
    if (self) {
        
        // @property TMDB *context;
        _context = context;
        
        // @property NSDictionary *rawData;
        _rawData = tvSeason;
        
        
        // @property NSNumber *parentID;
        //_parentID = [_rawData valueForKey:@"parentID"];
        _parentID = [_rawData extractValueforKey:@"parentID" ifClass:[NSString class]];
        
        // @property NSDate *air_date;
        //_air_date = [_rawData valueForKey:@"air_date"];
        _air_date = [_rawData extractValueforKey:@"air_date" ifClass:[NSDate class]];
        
        // @property NSNumber *identifier;
        //_identifier = [_rawData valueForKey:@"id"];
        _identifier = [_rawData extractValueforKey:@"id" ifClass:[NSNumber class]];
        
        // @property NSString *poster_path;
        //_poster_path = [_rawData valueForKey:@"poster_path"];
        _poster_path = [_rawData extractValueforKey:@"poster_path" ifClass:[NSString class]];
        
        // @property NSNumber *season_number;
        //_season_number = [_rawData valueForKey:@"season_number"];
        _season_number = [_rawData extractValueforKey:@"season_number" ifClass:[NSNumber class]];
        
        
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

- (void)tvSeason {
    [self.context tvSeasonWithID:[[self parentID] intValue] andSeasonNumber:[[self season_number] intValue]];
}

@end
