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
    if (error)
	{
		//NSLog(@"iTMDb: TMDBMovie request failed: %@", [error description]);
		if (_context)
			[_context tvDidFailLoading:self error:error];
		return;
	}
    
    _rawResults = [[NSArray alloc] initWithArray:(NSArray *)[[request parsedData] valueForKey:@"results"] copyItems:YES];
    
    NSLog(@"parsedData : %@", [request parsedData]);
    
    NSLog(@"rawResults : %@", _rawResults);
    NSLog(@"rawResults : %lu", (unsigned long)[_rawResults count]);
    NSLog(@"rawResults : %@", [_rawResults objectAtIndex:0]);
    
    NSLog(@"rawResults : %@", [_rawResults class]);
    NSLog(@"rawResults : %@", [[_rawResults objectAtIndex:0] class]);
    NSLog(@"rawResults : %@", [[_rawResults objectAtIndex:0] valueForKey:@"id"]);
    
    _request = nil;
    
    NSLog(@"rawResults : %@", _rawResults);
    NSLog(@"rawResults : %lu", (unsigned long)[_rawResults count]);
    NSLog(@"rawResults : %@", [_rawResults objectAtIndex:0]);
    
    NSLog(@"rawResults : %@", [_rawResults class]);
    NSLog(@"rawResults : %@", [[_rawResults objectAtIndex:0] class]);
    NSLog(@"rawResults : %@", [[_rawResults objectAtIndex:0] valueForKey:@"id"]);
    
    if ([_rawResults count] > 0) {
        _results = [NSMutableArray arrayWithCapacity:[_rawResults count]];
        int i;
        for (i=0; i<[_rawResults count]; i++) {
            NSDictionary *item = [_rawResults objectAtIndex:i];
            if (item && [item isMemberOfClass:[NSDictionary class]]) {
                TMDBPromisedMovie* tvSeries = [TMDBPromisedMovie promisedMovieFromDictionary:item withContext:self.context];
                [_results addObject:tvSeries];
                NSLog(@"item : %@", tvSeries);
            }
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
