//
//  TMDB.m
//  iTMDb
//
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//  Modified by Alessio Moiso on 16/01/13,
//  Copyright 2013 MrAsterisco. All rights reserved.
//

#import "TMDB.h"

@implementation TMDB

@dynamic apiKey;
@synthesize delegate=_delegate, language=_language;

- (id)initWithAPIKey:(NSString *)anApiKey delegate:(id<TMDBDelegate>)aDelegate language:(NSString *)aLanguage
{
	_delegate = aDelegate;
	_apiKey = [anApiKey copy];
	if (!aLanguage || [aLanguage length] == 0)
		_language = @"en";
	else
		_language = [aLanguage copy];

	return self;
}

- (void)dealloc {
    _apiKey = nil;
    _delegate = nil;
    _language = nil;
    _configuration = nil;
}

#pragma mark -
#pragma mark Notifications
- (void)movieDidFinishLoading:(id)aMovie
{
	if (_delegate) {
        if ([aMovie isMemberOfClass:[TMDBMovieCollection class]]) {
            [_delegate tmdb:self didFinishLoadingMovieCollection:aMovie];
            _movieCollection = nil;
        }
        else {
            [_delegate tmdb:self didFinishLoadingMovie:aMovie];
            _movie = nil;
        }
    }
}

- (void)movieDidFailLoading:(id)aMovie error:(NSError *)error
{
	if (_delegate) {
        if ([aMovie isMemberOfClass:[TMDBMovieCollection class]]) {
            [_delegate tmdb:self didFailLoadingMovieCollection:aMovie error:error];
            _movieCollection = nil;
        }
        else {
            [_delegate tmdb:self didFailLoadingMovie:aMovie error:error];
            _movie = nil;
        }
    }
}

- (void)tvDidFinishLoading:(id)aTV
{
    if (_delegate) {
        if ([aTV isMemberOfClass:[TMDBTVCollection class]]) {
            [_delegate tmdb:self didFinishLoadingTVCollection:aTV];
            //_tvCollection = nil;
        }
        else if ([aTV isMemberOfClass:[TMDBTVSeries class]]) {
            [_delegate tmdb:self didFinishLoadingTVSeries:aTV];
            //_tvSeries = nil;
        }
    }
}

- (void)tvDidFailLoading:(id)aTV error:(NSError *)error
{
    if (_delegate) {
        if ([aTV isMemberOfClass:[TMDBTVCollection class]]) {
            [_delegate tmdb:self didFailLoadingTVCollection:aTV error:error];
            //_tvCollection = nil;
        }
        else if ([aTV isMemberOfClass:[TMDBTVSeries class]]) {
            [_delegate tmdb:self didFailLoadingTVSeries:aTV error:error];
            //_tvSeries = nil;
        }
    }
}

#pragma mark -
#pragma mark Shortcuts
- (void)movieWithID:(NSInteger)anID
{
    self.movie = [TMDBMovie movieWithID:anID context:self];
}

- (void)movieWithName:(NSString *)aName
{
	self.movieCollection = [TMDBMovieCollection collectionWithName:aName andContext:self];
}

- (void)tvSeriesWithID:(NSInteger)anID {
    self.tvSeries = [TMDBTVSeries tvSeriesWithID:anID context:self];
}
- (void)tvCollectionWithName:(NSString *)aName {
    self.tvCollection = [TMDBTVCollection collectionWithName:aName andContext:self];
}

#pragma mark -
#pragma mark Getters and setters
- (NSString *)apiKey
{
	return _apiKey;
}

- (void)setApiKey:(NSString *)newKey
{
	// TODO: Invalidate active token
	_apiKey = [newKey copy];
}

#pragma mark -

@end