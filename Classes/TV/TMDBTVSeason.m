//
//  TMDBTVSeason.m
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

#import "TMDBTVSeason.h"
#import "TMDB.h"

#import "NSDictionary+extractValue.h"

@interface TMDBTVSeason ()

- (id)initWithURL:(NSURL *)url context:(TMDB *)context;
- (id)initWithURL:(NSURL *)url context:(TMDB *)context userData:(NSDictionary *)userData;

- (NSArray *)arrayWithImages:(NSArray *)images ofType:(TMDBImageType)type;

@end

@implementation TMDBTVSeason
/*
@dynamic year;
*/
#pragma mark -
#pragma mark Constructors

+ (TMDBTVSeason *)tvSeasonWithID:(NSInteger)anID andSeasonNumber:(NSInteger)aSeason context:(TMDB *)aContext {
	return [[TMDBTVSeason alloc] initWithID:anID andSeasonNumber:aSeason context:aContext];
    
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext {
	return [self initWithURL:url context:aContext userData:nil];
    
}

- (id)initWithURL:(NSURL *)url context:(TMDB *)aContext userData:(NSDictionary *)userData {
    
    if ((self = [self init])) {
		_context = aContext;
		_rawResults = nil;
        
		// Initialize the fetch request
		_request = [TMDBRequest requestWithURL:url delegate:self];
	}

	return self;
}

- (id)initWithID:(NSInteger)anID andSeasonNumber:(NSInteger)aSeason context:(TMDB *)aContext {
    NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/tv/%ld/season/%ld?api_key=%@&language=%@&append_to_response=casts,images,keywords",
									   API_VERSION, anID, aSeason, aContext.apiKey, aContext.language]];
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
}*/

#pragma mark -
#pragma mark TMDBRequestDelegate
- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error
{
	if (error)
	{
		if (_context)
			[_context tvDidFailLoading:self error:error];
		return;
	}

	_rawResults = [request parsedData];
    
    //NSLog(@"%@", _rawResults);

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
    
    // @property NSDate *air_date;
    _air_date = [_rawResults extractValueforKey:@"air_date" ifClass:[NSDate class]];
    // @property NSArray *episodes;
    _episodes = [_rawResults extractValueforKey:@"episodes" ifClass:[NSArray class]];
    // @property NSNumber *identifier;
    _identifier = [_rawResults extractValueforKey:@"id" ifClass:[NSNumber class]];
    // @property NSArray *images;
    _images = [_rawResults extractValueforKey:@"images" ifClass:[NSArray class]];
    // @property NSString *name;
    _name = [_rawResults extractValueforKey:@"name" ifClass:[NSString class]];
    // @property NSString *overview;
    _overview = [_rawResults extractValueforKey:@"overview" ifClass:[NSString class]];
    // @property NSNumber *season_number;
    _season_number = [_rawResults extractValueforKey:@"season_number" ifClass:[NSNumber class]];
    
    _request = nil;
    
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