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

#import "TMDBPromisedTVEpisodes.h"
#import "TMDBImage.h"

#import "NSDictionary+extractValue.h"

@implementation TMDBPromisedTVEpisodes

+ (TMDBPromisedTVEpisodes*)promisedTVEpisodesFromDictionary:(NSDictionary*)tvEpisodes withContext:(TMDB*)context {
    return [[TMDBPromisedTVEpisodes alloc] initWithContentsOfDictionary:tvEpisodes fromContext:context];
}

- (id)initWithContentsOfDictionary:(NSDictionary*)tvEpisodes fromContext:(TMDB*)context {
    self = [super init];
    if (self) {
        
        // @property TMDB *context;
        _context = context;
        
        // @property NSDictionary *rawData;
        _rawData = tvEpisodes;
        
        
        // @property NSNumber *parentID;
        _parentID = [_rawData extractValueforKey:@"parentID" ifClass:[NSString class]];
        
        // @property NSDate *air_date;
        _air_date = [_rawData extractValueforKey:@"air_date" ifClass:[NSDate class]];
        
        // @property NSArray *crew;
        _crew = [_rawData extractValueforKey:@"crew" ifClass:[NSArray class]];
        
        // @property NSNumber *episode_number;
        _episode_number = [_rawData extractValueforKey:@"episode_number" ifClass:[NSNumber class]];
        
        // @property NSArray *guest_stars;
        _guest_stars = [_rawData extractValueforKey:@"guest_stars" ifClass:[NSArray class]];
        
        // @property NSString *name;
        _name = [_rawData extractValueforKey:@"name" ifClass:[NSString class]];
        
        // @property NSString *overview;
        _overview = [_rawData extractValueforKey:@"overview" ifClass:[NSString class]];
        
        // @property NSNumber *identifier;
        _identifier = [_rawData extractValueforKey:@"id" ifClass:[NSNumber class]];
        
        // @property NSNumber *production_code;
        _production_code = [_rawData extractValueforKey:@"production_code" ifClass:[NSNumber class]];
        
        // @property NSNumber *season_number;
        _season_number = [_rawData extractValueforKey:@"season_number" ifClass:[NSNumber class]];
        
        // @property NSString *still_path;
        _still_path = [_rawData extractValueforKey:@"still_path" ifClass:[NSString class]];
        
        // @property NSNumber *vote_average;
        _vote_average = [_rawData extractValueforKey:@"vote_average" ifClass:[NSNumber class]];
        
        // @property NSNumber *vote_count;
        _vote_count = [_rawData extractValueforKey:@"vote_count" ifClass:[NSNumber class]];
        
        
        // @property NSImage *loadedPoster;
        // @property TMDBImage *loadingPoster;
        
    }
    return self;
}

- (void)loadPoster {
    if (self.still_path != nil || ![self.still_path isMemberOfClass:[NSNull class]]) {
        [self performSelectorInBackground:@selector(loadPosterInBackgroundThread) withObject:nil];
    }
}

- (void)loadPosterInBackgroundThread {
    @autoreleasepool {
        if ([self.still_path respondsToSelector:@selector(length)]) {
            self.loadingPoster = [[TMDBImage alloc] initWithAddress:[NSURL URLWithString:self.still_path] context:self.context delegate:self andContextInfo:nil];
        }
    }
}

- (void)tmdbImageInContext:(TMDB*)context didFinishLoading:(NSImage*)aImage {
    _loadingPoster = nil;
    self.loadedPoster = aImage;
}

- (void)tvEpisodes {
    //[self.context tvEpisodesWithID:[[self parentID] intValue] SeasonNumber:[[self season_number] intValue]] andEpisodeNumber:[[self episode_number] intValue]];
}

@end
