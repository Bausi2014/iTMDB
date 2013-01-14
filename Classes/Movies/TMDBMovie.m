//
//  TMDBMovie.m
//  iTMDb
//
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//

#import "TMDB.h"
#import "TMDBMovie.h"
#import "TMDBImage.h"
#import "TMDBPerson.h"

@interface TMDBMovie ()

- (id)initWithURL:(NSURL *)url context:(TMDB *)context;
- (id)initWithURL:(NSURL *)url context:(TMDB *)context userData:(NSDictionary *)userData;

- (NSArray *)arrayWithImages:(NSArray *)images ofType:(TMDBImageType)type;

@end

@implementation TMDBMovie

@synthesize context=_context,
            rawResults=_rawResults,
            id=_id,
			userData=_userData,
            title=_title,
            released=_released,
            overview=_overview,
            runtime=_runtime,
            tagline=_tagline,
            homepage=_homepage,
            imdbID=_imdbID,
            posters=_posters,
            backdrops=_backdrops,
			language=_language,
			translated=_translated,
			adult=_adult,
			url=_url,
			votes=_votes,
			certification=_certification,
			categories=_categories,
			keywords=_keywords,
			languagesSpoken=_languagesSpoken,
			countries=_countries,
			cast=_cast;
@dynamic year;

#pragma mark -
#pragma mark Constructors

+ (TMDBMovie *)movieWithID:(NSInteger)anID context:(TMDB *)aContext
{
	return [[TMDBMovie alloc] initWithID:anID context:aContext];
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext
{
	return [self initWithURL:url context:aContext userData:nil];
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext userData:(NSDictionary *)userData
{
	if ((self = [self init]))
	{
		_context = aContext;

		_rawResults = nil;

		_id = 0;
		_userData = userData;
		_title = nil;
		_released = nil;
		_overview = nil;
		_runtime = 0;
		_tagline = nil;
		_homepage = nil;
		_imdbID = nil;
		_posters = nil;
		_backdrops = nil;
		_rating = 0;
		_revenue = 0;
		_trailer = nil;
		_studios = nil;
		_originalName = nil;
		_alternativeName = nil;
		_popularity = 0;
		_translated = NO;
		_adult = NO;
		_language = nil;
		_url = nil;
		_votes = 0;
		_certification = nil;
		_categories = nil;
		_keywords = nil;
		_languagesSpoken = nil;
		_countries = nil;
		_cast = nil;
		_version = 0;
		_modified = nil;
		
		// Initialize the fetch request
		_request = [TMDBRequest requestWithURL:url delegate:self];
	}

	return self;
}

- (id)initWithID:(NSInteger)anID context:(TMDB *)aContext
{
    ///3/movie/{id}
    
	NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/movie/%ld?api_key=%@&language=%@",
									   API_VERSION, anID, aContext.apiKey, aContext.language]];
	isSearchingOnly = NO;
	return [self initWithURL:url context:aContext];
}

#pragma mark -

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
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"YYYY"];
	return [[df stringFromDate:self.released] integerValue];
}

#pragma mark -
#pragma mark TMDBRequestDelegate
- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error
{
	if (error)
	{
		//NSLog(@"iTMDb: TMDBMovie request failed: %@", [error description]);
		if (_context)
			[_context movieDidFailLoading:self error:error];
		return;
	}

	_rawResults = [[NSArray alloc] initWithArray:(NSArray *)[request parsedData] copyItems:YES];

	if (!_rawResults || ![_rawResults count] > 0 || ![[_rawResults objectAtIndex:0] isKindOfClass:[NSDictionary class]])
	{
		//NSLog(@"iTMDb: Returned data is NOT a dictionary!\n%@", _rawResults);
		if (_context)
		{
			NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
									   [NSString stringWithFormat:@"The data source (themoviedb) returned invalid data: %@", _rawResults],
									   NSLocalizedDescriptionKey,
									   nil];
			NSError *failError = [NSError errorWithDomain:@"Invalid data"
													 code:0
												 userInfo:errorDict];
			[_context movieDidFailLoading:self error:failError];
		}
		return;
	}

	NSDictionary *d = [_rawResults objectAtIndex:0];

	// SIMPLE DATA
	_id       = [(NSNumber *)[d objectForKey:@"id"] integerValue];
	_title    = [[d objectForKey:@"name"] copy];

	if ([d objectForKey:@"overview"] && [[d objectForKey:@"overview"] isKindOfClass:[NSString class]])
		_overview = [[d objectForKey:@"overview"] copy];
	else
		_overview = nil;

	if ([d objectForKey:@"tagline"] && [[d objectForKey:@"tagline"] isKindOfClass:[NSString class]])
		_tagline  = [[d objectForKey:@"tagline"] copy];
	if ([d objectForKey:@"imdb_id"] && [[d objectForKey:@"imdb_id"] isKindOfClass:[NSString class]])
		_imdbID   = [[d objectForKey:@"imdb_id"] copy];

	// COMPLEX DATA

	// Original name
	if ([d objectForKey:@"original_name"])
		_originalName = [[d objectForKey:@"original_name"] copy];

	// Alternative name
	if ([d objectForKey:@"alternative_name"])
		_alternativeName = [[d objectForKey:@"alternative_name"] copy];

	// Keywords
	if ([d objectForKey:@"keywords"] && [[d objectForKey:@"keywords"] isKindOfClass:[NSArray class]])
	{
		//_keywords = [[NSArray alloc] initWithArray:[d objectForKey:@"keywords"] copyItems:YES];
		_keywords = [[d objectForKey:@"keywords"] copy];
	}

	// URL
	if ([d objectForKey:@"url"])
		_url = [NSURL URLWithString:[d objectForKey:@"url"]];

	// Popularity
	if ([d objectForKey:@"popularity"])
		_popularity = [[d objectForKey:@"popularity"] integerValue];

	// Votes
	if ([d objectForKey:@"votes"])
		_votes = [[d objectForKey:@"votes"] integerValue];

	// Rating
	if ([d objectForKey:@"rating"])
		_rating = [[d objectForKey:@"rating"] floatValue];

	// Certification
	if ([d objectForKey:@"certification"])
		_certification = [[d objectForKey:@"certification"] copy];

	// Translated
	if ([d objectForKey:@"translated"] && ![[d objectForKey:@"translated"] isKindOfClass:[NSNull class]])
		_translated = [[d objectForKey:@"translated"] boolValue];

	// Adult
	if ([d objectForKey:@"adult"] && ![[d objectForKey:@"adult"] isKindOfClass:[NSNull class]])
		_adult = [[d objectForKey:@"adult"] boolValue];

	// Language
	if ([d objectForKey:@"language"])
		_language = [[d objectForKey:@"language"] copy];

	// Version
	if ([d objectForKey:@"version"])
		_version = [[d objectForKey:@"version"] integerValue];

	// Release date
	if ([d objectForKey:@"released"] && [[d objectForKey:@"released"] isKindOfClass:[NSString class]])
	{
		NSDateFormatter *releasedFormatter = [[NSDateFormatter alloc] init];
		[releasedFormatter setDateFormat:@"yyyy-MM-dd"];
		_released = [releasedFormatter dateFromString:(NSString *)[d objectForKey:@"released"]];
	}

	// Runtime
	if (!([d objectForKey:@"runtime"] == nil || [[d objectForKey:@"runtime"] isKindOfClass:[NSNull class]]))
		_runtime  = [[d objectForKey:@"runtime"] unsignedIntegerValue];

	// Homepage
	if ([d objectForKey:@"homepage"] && [[d objectForKey:@"homepage"] isKindOfClass:[NSString class]])
		_homepage = [NSURL URLWithString:[d objectForKey:@"homepage"]];
	else
		_homepage = nil;

	// Posters
	_posters = nil;
	if ([d objectForKey:@"posters"])
		_posters = [self arrayWithImages:[d objectForKey:@"posters"] ofType:TMDBImageTypePoster];
	//NSLog(@"POSTERS %@", _posters);

	// Backdrops
	_backdrops = nil;
	if ([d objectForKey:@"backdrops"])
		_backdrops = [self arrayWithImages:[d objectForKey:@"backdrops"] ofType:TMDBImageTypeBackdrop];
	//NSLog(@"BACKDROPS %@", _backdrops);

	// Cast
	_cast = nil;
	if ([d objectForKey:@"cast"] && ![d isKindOfClass:[NSNull class]])
		_cast = [TMDBPerson personsWithMovie:self personsInfo:[d objectForKey:@"cast"]];

	if (isSearchingOnly)
	{
		isSearchingOnly = NO;
		id myself = [self initWithID:_id context:_context];
#pragma unused (myself)
		return;
	}

	// Notify the context that the movie info has been loaded
	if (_context)
		[_context movieDidFinishLoading:self];
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

#pragma mark -

@end