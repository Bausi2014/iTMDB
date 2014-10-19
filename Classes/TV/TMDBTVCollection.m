//
//  TMDBTVCollection.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBMovieCollection.m
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import "TMDBTVCollection.h"
#import "TMDB.h"
#import "TMDBPromisedTVSeries.h"

@implementation TMDBTVCollection

+ (TMDBTVCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context {
    return [[TMDBTVCollection alloc] initWithName:name andContext:context];
    
}

- (id)initWithName:(NSString*)aName andContext:(TMDB*)aContext {
    self = [super init];
    if (self) {
        _name = aName;
        _results = [NSMutableArray array];
        NSString *aNameEscaped = [aName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%.1d/search/tv?api_key=%@&language=%@&query=%@",
                                           API_VERSION, aContext.apiKey, aContext.language, aNameEscaped]];
        _context = aContext;
        _request = [TMDBRequest requestWithURL:url delegate:self];
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %@>", [self class], self.name];
}

#pragma mark -
#pragma mark TMDBRequestDelegate

- (void)request:(TMDBRequest *)request didFinishLoading:(NSError *)error {
    
    if (error) {
		//NSLog(@"iTMDb: TMDBMovie request failed: %@", [error description]);
		if (_context)
			[_context tvDidFailLoading:self error:error];
		return;
	}
    
    _rawResults = [[NSArray alloc] initWithArray:(NSArray *)[[request parsedData] valueForKey:@"results"] copyItems:YES];
    
    // @property NSNumber* page;
    _page = [[request parsedData] valueForKey:@"page"];
    
    // @property NSNumber* total_pages;
    _total_pages = [[request parsedData] valueForKey:@"total_pages"];
    
    // @property NSNumber* total_results;
    _total_results = [[request parsedData] valueForKey:@"total_results"];
    
    _request = nil;
    
    if ([_rawResults count] != 0) {
        
        _results = [NSMutableArray arrayWithCapacity:[_rawResults count]];
        for (NSDictionary *tvSeries in _rawResults) {
            TMDBPromisedTVSeries *proTVSeries = [TMDBPromisedTVSeries promisedTVSeriesFromDictionary:tvSeries withContext:self.context];
            [_results addObject:proTVSeries];
        }
        
        if (_context)
            [_context tvDidFinishLoading:self];
    }
    else {
        if (_context)
            [_context tvDidFailLoading:self error:[NSError errorWithDomain:@"iTMDB" code:-4032 userInfo:nil]];
    }
}

@end
