//
//  TMDBTVSeries.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBMovie.m
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import "TMDBTVSeries.h"
#import "TMDB.h"

#import "NSDictionary+extractValue.h"

@interface TMDBTVSeries ()

- (id)initWithURL:(NSURL *)url context:(TMDB *)context;
- (id)initWithURL:(NSURL *)url context:(TMDB *)context userData:(NSDictionary *)userData;

- (NSArray *)arrayWithImages:(NSArray *)images ofType:(TMDBImageType)type;

@end

@implementation TMDBTVSeries
/*
@dynamic year;
*/
#pragma mark -
#pragma mark Constructors

+ (TMDBTVSeries *)tvSeriesWithID:(NSInteger)anID context:(TMDB *)aContext
{
	return [[TMDBTVSeries alloc] initWithID:anID context:aContext];
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext
{
	return [self initWithURL:url context:aContext userData:nil];
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext userData:(NSDictionary *)userData {
    self = [self init];
    if (self) {
        _context = aContext;
        _rawResults = nil;
        
        // Initialize the fetch request
        _request = [TMDBRequest requestWithURL:url delegate:self];
	}

	return self;
}

- (id)initWithID:(NSInteger)anID context:(TMDB *)aContext {
    NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/tv/%ld?api_key=%@&language=%@&append_to_response=casts,images,keywords",
									   API_VERSION, anID, aContext.apiKey, aContext.language]];
    
	return [self initWithURL:url context:aContext];
}

#pragma mark -
/*
- (NSString *)description
{
	if (!self.title)
		return [NSString stringWithFormat:@"<%@>", [self class], nil];

	if (!self.released)
		return [NSString stringWithFormat:@"<%@: %@>", [self class], self.title, nil];

	NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *weekdayComponents = [cal components:NSYearCalendarUnit fromDate:self.released];
	NSInteger year = [weekdayComponents year];

	return [NSString stringWithFormat:@"<%@: %@ (%li)>", [self class], self.title, year, nil];
}

#pragma mark -
- (NSUInteger)year
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self.released];
    return [comp year];
}
*/
#pragma mark -
#pragma mark TMDBRequestDelegate
- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    
	if (error)
	{
		if (_context)
			[_context tvDidFailLoading:self error:error];
		return;
	}

    //@property NSDictionary *rawResults;
	_rawResults = [request parsedData];
	if (!_rawResults)
	{
		if (_context)
		{
			NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
									   [NSString stringWithFormat:@"The data source (themoviedb) returned invalid data: %@", _rawResults],
									   NSLocalizedDescriptionKey,
									   nil];
			NSError *failError = [NSError errorWithDomain:@"Invalid data"
													 code:0
												 userInfo:errorDict];
			[_context tvDidFailLoading:self error:failError];
		}
		return;
	}
    
    //@property NSString *backdrop_path;
    _backdrop_path = [_rawResults extractValueforKey:@"backdrop_path" ifClass:[NSString class]];
    //@property NSArray *created_by;
    _created_by = [_rawResults extractValueforKey:@"created_by" ifClass:[NSArray class]];
    //@property NSNumber *episode_run_time;
    _episode_run_time = [_rawResults extractValueforKey:@"episode_run_time" ifClass:[NSArray class]];
    //@property NSDate *first_air_date;
    _first_air_date = [_rawResults extractValueforKey:@"first_air_date" ifClass:[NSDate class]];
    //@property NSArray *genres;
    _genres = [_rawResults extractValueforKey:@"genres" ifClass:[NSArray class]];
    //@property NSURL *homepage;
    _homepage = [_rawResults extractValueforKey:@"homepage" ifClass:[NSURL class]];
    //@property NSNumber *id;
    _identifier = [_rawResults extractValueforKey:@"id" ifClass:[NSNumber class]];
    //@property NSArray *images;
    _images = [_rawResults extractValueforKey:@"images" ifClass:[NSArray class]];
    //@property NSNumber *in_production;
    _in_production = [_rawResults extractValueforKey:@"in_production" ifClass:[NSNumber class]];
    //@property NSArray *keywords;
    _keywords = [_rawResults extractValueforKey:@"keywords" ifClass:[NSArray class]];
    //@property NSArray *languages;
    _languages = [_rawResults extractValueforKey:@"languages" ifClass:[NSArray class]];
    //@property NSDate *last_air_date;
    _last_air_date = [_rawResults extractValueforKey:@"last_air_date" ifClass:[NSDate class]];
    //@property NSString *name;
    _name = [_rawResults extractValueforKey:@"name" ifClass:[NSString class]];
    //@property NSArray *networks;
    _networks = [_rawResults extractValueforKey:@"networks" ifClass:[NSArray class]];
    //@property NSNumber *number_of_episodes;
    _number_of_episodes = [_rawResults extractValueforKey:@"number_of_episodes" ifClass:[NSNumber class]];
    //@property NSNumber *number_of_seasons;
    _number_of_seasons = [_rawResults extractValueforKey:@"number_of_seasons" ifClass:[NSNumber class]];
    //@property NSArray *origin_country;
    _origin_country = [_rawResults extractValueforKey:@"origin_country" ifClass:[NSArray class]];
    //@property NSString *original_name;
    _original_name = [_rawResults extractValueforKey:@"original_name" ifClass:[NSString class]];
    //@property NSString *overview;
    _overview = [_rawResults extractValueforKey:@"overview" ifClass:[NSString class]];
    //@property NSNumber *popularity;
    _popularity = [_rawResults extractValueforKey:@"popularity" ifClass:[NSNumber class]];
    //@property NSString *poster_path;
    _poster_path = [_rawResults extractValueforKey:@"poster_path" ifClass:[NSString class]];
    //@property NSArray *production_companies;
    _production_companies = [_rawResults extractValueforKey:@"production_companies" ifClass:[NSArray class]];
    //@property NSArray *seasons;
    _seasons = [_rawResults extractValueforKey:@"seasons" ifClass:[NSArray class]];
    //@property NSString *status;
    _status = [_rawResults extractValueforKey:@"status" ifClass:[NSString class]];
    //@property NSNumber *vote_average;
    _vote_average = [_rawResults extractValueforKey:@"vote_average" ifClass:[NSNumber class]];
    //@property NSNumber *vote_count;
    _vote_count = [_rawResults extractValueforKey:@"vote_count" ifClass:[NSNumber class]];
    
    //@property *request;
    _request = nil;
    
    //@property TMDB *context;
    if (_context)
		[_context tvDidFinishLoading:self];
}

#pragma mark - Helper methods
- (NSArray *)arrayWithImages:(NSArray *)theImages ofType:(TMDBImageType)aType {
	NSMutableArray *imageObjects = [NSMutableArray arrayWithCapacity:0];

	// outerImageDict: the TMDb API wraps each image in a wrapper dictionary (e.g. each backdrop has an "images" dictionary)
	for (NSDictionary *outerImageDict in theImages)
	{
		// innerImageDict: the image info (see outerImageDict)
		NSDictionary *innerImageDict = [outerImageDict objectForKey:@"image"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        if (aType == TMDBImageTypePoster) {
            if ([[innerImageDict valueForKey:@"type"] isEqualToString:@"poster"]) {
                [dict setValue:[innerImageDict valueForKey:@"url"] forKey:@"url"];
                [dict setValue:[innerImageDict valueForKey:@"width"] forKey:@"width"];
                [dict setValue:[innerImageDict valueForKey:@"height"] forKey:@"height"];
            }
        }
        else if (aType == TMDBImageTypeBackdrop) {
            if ([[innerImageDict valueForKey:@"type"] isEqualToString:@"backdrop"]) {
                [dict setValue:[innerImageDict valueForKey:@"url"] forKey:@"url"];
                [dict setValue:[innerImageDict valueForKey:@"width"] forKey:@"width"];
                [dict setValue:[innerImageDict valueForKey:@"height"] forKey:@"height"];
            }
        }
        
        [imageObjects addObject:dict];
	}
	return imageObjects;
}

@end