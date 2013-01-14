//
//  TMDBToken.m
//  iTMDb
//
//  Created by Christian Rasmussen on 04/11/10.
//  Copyright 2010 Apoltix. All rights reserved.
//

#import "TMDBToken.h"

#import "TMDBRequest.h"
#import "TMDBRequestDelegate.h"

@implementation TMDBToken

+ (TMDBToken *)tokenWithContext:(TMDB *)context delegate:(id <TMDBRequestDelegate>)delegate
{
	return [[TMDBToken alloc] initWithContext:context delegate:delegate];
}

- (id)initWithContext:(TMDB *)context delegate:(id <TMDBRequestDelegate>)delegate
{
	if ((self = [self init]))
	{
		_request = [TMDBRequest requestWithURL:[NSURL URLWithString:[API_URL_BASE stringByAppendingFormat:@"%i/Auth.getToken/json/%@"]]
									  delegate:delegate];
	}

	return self;
}

@end