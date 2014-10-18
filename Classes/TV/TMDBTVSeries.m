//
//  TMDBTVSeries.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derrived from TMDBMovie.m
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import "TMDB.h"
#import "TMDBTVSeries.h"
#import "TMDBImage.h"
#import "TMDBPromisedPerson.h"
#import "TMDBKeyword.h"
#import "TMDBGenre.h"
#import "TMDBCountry.h"
#import "TMDBLanguage.h"
#import "TMDBCompany.h"

#import "NSDictionary+extractValue.h"

@interface TMDBTVSeries ()

- (id)initWithURL:(NSURL *)url context:(TMDB *)context;
- (id)initWithURL:(NSURL *)url context:(TMDB *)context userData:(NSDictionary *)userData;

- (NSArray *)arrayWithImages:(NSArray *)images ofType:(TMDBImageType)type;

@end

@implementation TMDBTVSeries
/*
@synthesize context = _context,
            request = _request,
            rawResults = _rawResults,
            backdrop_path = _backdrop_path,
            created_by = _created_by,
            episode_run_time = _episode_run_time,
            first_air_date = _first_air_date,
            genres = _genres,
            homepage = _homepage,
            id = _id,
            images = _images,
            in_production = _in_production,
            keywords = _keywords,
            languages = _languages,
            last_air_date = _last_air_date,
            name = _name,
            networks = _networks,
            number_of_episodes = _number_of_episodes,
            number_of_seasons = _number_of_seasons,
            origin_country = _origin_country,
            original_name = _original_name,
            overview = _overview,
            popularity = _popularity,
            poster_path = _poster_path,
            production_companies = _production_companies,
            seasons = _seasons,
            status = _status,
            vote_average = _vote_average,
            vote_count = _vote_count;
 */
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

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext userData:(NSDictionary *)userData
{
    if ((self = [self init]))
	{
        //@property (nonatomic, strong, readonly) TMDB			*context;
        //@property (nonatomic, readwrite) TMDBRequest            *request;
        //@property (nonatomic, strong, readonly) NSDictionary	*rawResults;
        
        //@property (nonatomic, strong, readonly) NSString		*backdrop_path;
        //@property (nonatomic, strong, readonly) NSArray         *created_by;
        //@property (nonatomic, strong, readonly) NSNumber		*episode_run_time;
        //@property (nonatomic, strong, readonly) NSDate          *first_air_date;
        
        //@property (nonatomic, strong, readonly) NSArray         *genres;
        //@property (nonatomic, strong, readonly) NSURL			*homepage;
        //@property (nonatomic, strong, readonly) NSNumber		*id;
        //@property (nonatomic, strong, readonly) NSArray         *images;
        //@property (nonatomic, strong, readonly) NSNumber		*in_production;
        //@property (nonatomic, strong, readonly) NSArray			*keywords;
        //@property (nonatomic, strong, readonly) NSArray         *languages;
        //@property (nonatomic, strong, readonly) NSDate          *last_air_date;
        //@property (nonatomic, strong, readonly) NSString		*name;
        //@property (nonatomic, strong, readonly) NSArray         *networks;
        //@property (nonatomic, strong, readonly) NSNumber		*number_of_episodes;
        //@property (nonatomic, strong, readonly) NSNumber		*number_of_seasons;
        //@property (nonatomic, strong, readonly) NSArray         *origin_country;
        //@property (nonatomic, strong, readonly) NSString		*original_name;
        //@property (nonatomic, strong, readonly) NSString		*overview;
        //@property (nonatomic, strong, readonly) NSNumber		*popularity;
        //@property (nonatomic, strong, readonly) NSString		*poster_path;
        //@property (nonatomic, strong, readonly) NSArray         *production_companies;
        //@property (nonatomic, strong, readonly) NSArray         *seasons;
        //@property (nonatomic, strong, readonly) NSString		*status;
        //@property (nonatomic, strong, readonly) NSNumber		*vote_average;
        //@property (nonatomic, strong, readonly) NSNumber		*vote_count;
        
        //@property (nonatomic, readwrite) BOOL loaded;
		_context = aContext;
		_rawResults = nil;
        
        _backdrop_path = nil;
        _created_by = nil;
        _episode_run_time = 0;
        _first_air_date = nil;
        _genres = nil;
        _homepage = nil;
        _id = 0;
        _images = nil;
        _in_production = nil;
        _keywords = nil;
        _languages = nil;
        _last_air_date = nil;
        _name = nil;
        _networks = nil;
        _number_of_episodes = 0;
        _number_of_seasons = 0;
        _origin_country = nil;
        _original_name = nil;
        _overview = nil;
        _popularity = 0;
        _poster_path = nil;
        _production_companies = nil;
        _seasons = nil;
        _status = nil;
        _vote_average = 0;
        _vote_count = 0;
        
		// Initialize the fetch request
		_request = [TMDBRequest requestWithURL:url delegate:self];
	}

	return self;
}

- (id)initWithID:(NSInteger)anID context:(TMDB *)aContext
{
    NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/tv/%ld?api_key=%@&language=%@&append_to_response=casts,images,keywords",
									   API_VERSION, anID, aContext.apiKey, aContext.language]];
    
	isSearchingOnly = NO;
	return [self initWithURL:url context:aContext];
}

- (void)dealloc {
    //@property (nonatomic, strong, readonly) TMDB			*context;
    //@property (nonatomic, readwrite) TMDBRequest            *request;
    //@property (nonatomic, strong, readonly) NSDictionary	*rawResults;
    
    //@property (nonatomic, strong, readonly) NSString		*backdrop_path;
    //@property (nonatomic, strong, readonly) NSArray         *created_by;
    //@property (nonatomic, strong, readonly) NSNumber		*episode_run_time;
    //@property (nonatomic, strong, readonly) NSDate          *first_air_date;
    
    //@property (nonatomic, strong, readonly) NSArray         *genres;
    //@property (nonatomic, strong, readonly) NSURL			*homepage;
    //@property (nonatomic, strong, readonly) NSNumber		*id;
    //@property (nonatomic, strong, readonly) NSArray         *images;
    //@property (nonatomic, strong, readonly) NSNumber		*in_production;
    //@property (nonatomic, strong, readonly) NSArray			*keywords;
    //@property (nonatomic, strong, readonly) NSArray         *languages;
    //@property (nonatomic, strong, readonly) NSDate          *last_air_date;
    //@property (nonatomic, strong, readonly) NSString		*name;
    //@property (nonatomic, strong, readonly) NSArray         *networks;
    //@property (nonatomic, strong, readonly) NSNumber		*number_of_episodes;
    //@property (nonatomic, strong, readonly) NSNumber		*number_of_seasons;
    //@property (nonatomic, strong, readonly) NSArray         *origin_country;
    //@property (nonatomic, strong, readonly) NSString		*original_name;
    //@property (nonatomic, strong, readonly) NSString		*overview;
    //@property (nonatomic, strong, readonly) NSNumber		*popularity;
    //@property (nonatomic, strong, readonly) NSString		*poster_path;
    //@property (nonatomic, strong, readonly) NSArray         *production_companies;
    //@property (nonatomic, strong, readonly) NSArray         *seasons;
    //@property (nonatomic, strong, readonly) NSString		*status;
    //@property (nonatomic, strong, readonly) NSNumber		*vote_average;
    //@property (nonatomic, strong, readonly) NSNumber		*vote_count;
    
    //@property (nonatomic, readwrite) BOOL loaded;
    _context = nil;
    _rawResults = nil;
    
    _backdrop_path = nil;
    _created_by = nil;
    _episode_run_time = 0;
    _first_air_date = nil;
    _genres = nil;
    _homepage = nil;
    _id = 0;
    _images = nil;
    _in_production = nil;
    _keywords = nil;
    _languages = nil;
    _last_air_date = nil;
    _name = nil;
    _networks = nil;
    _number_of_episodes = 0;
    _number_of_seasons = 0;
    _origin_country = nil;
    _original_name = nil;
    _overview = nil;
    _popularity = 0;
    _poster_path = nil;
    _production_companies = nil;
    _seasons = nil;
    _status = nil;
    _vote_average = 0;
    _vote_count = 0;
    
    _request = nil;
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

    //@property (nonatomic, strong, readonly) NSDictionary	*rawResults;
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
    
    NSLog(@"RawResults : %@", _rawResults);
    
    //@property (nonatomic, strong, readonly) NSString		*backdrop_path;
    _backdrop_path = [_rawResults extractValueforKey:@"backdrop_path" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSArray       *created_by;
    _created_by = [_rawResults extractValueforKey:@"created_by" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSNumber		*episode_run_time;
    _episode_run_time = [_rawResults extractValueforKey:@"episode_run_time" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSDate        *first_air_date;
    _first_air_date = [_rawResults extractValueforKey:@"first_air_date" ifClass:[NSDate class]];
    //@property (nonatomic, strong, readonly) NSArray       *genres;
    _genres = [_rawResults extractValueforKey:@"genres" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSURL			*homepage;
    _homepage = [_rawResults extractValueforKey:@"homepage" ifClass:[NSURL class]];
    //@property (nonatomic, strong, readonly) NSNumber		*id;
    _id = [_rawResults extractValueforKey:@"id" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSArray       *images;
    _images = [_rawResults extractValueforKey:@"images" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSNumber		*in_production;
    _in_production = [_rawResults extractValueforKey:@"in_production" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSArray       *keywords;
    _keywords = [_rawResults extractValueforKey:@"keywords" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSArray       *languages;
    _languages = [_rawResults extractValueforKey:@"languages" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSDate        *last_air_date;
    _last_air_date = [_rawResults extractValueforKey:@"last_air_date" ifClass:[NSDate class]];
    //@property (nonatomic, strong, readonly) NSString		*name;
    _name = [_rawResults extractValueforKey:@"name" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSArray       *networks;
    _networks = [_rawResults extractValueforKey:@"networks" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSNumber		*number_of_episodes;
    _number_of_episodes = [_rawResults extractValueforKey:@"number_of_episodes" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSNumber		*number_of_seasons;
    _number_of_seasons = [_rawResults extractValueforKey:@"number_of_seasons" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSArray       *origin_country;
    _origin_country = [_rawResults extractValueforKey:@"origin_country" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSString		*original_name;
    _original_name = [_rawResults extractValueforKey:@"original_name" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSString		*overview;
    _overview = [_rawResults extractValueforKey:@"overview" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSNumber		*popularity;
    _popularity = [_rawResults extractValueforKey:@"popularity" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSString		*poster_path;
    _poster_path = [_rawResults extractValueforKey:@"poster_path" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSArray       *production_companies;
    _production_companies = [_rawResults extractValueforKey:@"production_companies" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSArray       *seasons;
    _seasons = [_rawResults extractValueforKey:@"seasons" ifClass:[NSArray class]];
    //@property (nonatomic, strong, readonly) NSString		*status;
    _status = [_rawResults extractValueforKey:@"status" ifClass:[NSString class]];
    //@property (nonatomic, strong, readonly) NSNumber		*vote_average;
    _vote_average = [_rawResults extractValueforKey:@"vote_average" ifClass:[NSNumber class]];
    //@property (nonatomic, strong, readonly) NSNumber		*vote_count;
    _vote_count = [_rawResults extractValueforKey:@"vote_count" ifClass:[NSNumber class]];
    
    //@property (nonatomic, readwrite) BOOL loaded;
    _loaded = YES;
    
    //@property (nonatomic, readwrite) TMDBRequest          *request;
    _request = nil;
    
    //@property (nonatomic, strong, readonly) TMDB			*context;
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