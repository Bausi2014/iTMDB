//
//  TMDBTVCollection.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derrived from TMDBMovieCollection.h
//  Created by Alessio Moiso on 13/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TMDBRequestDelegate.h"
#import "TMDBPromisedTVSeries.h"
#import "TMDBImage.h"

@class TMDB;

@interface TMDBTVCollection : NSObject <TMDBRequestDelegate>

@property NSMutableArray *results;
@property TMDBRequest *request;
@property TMDB *context;
@property NSArray *rawResults;
@property NSString *name;
@property id contextInfo;

+ (TMDBTVCollection*)collectionWithName:(NSString*)name andContext:(TMDB*)context;

- (id)initWithName:(NSString*)aName andContext:(TMDB*)aContext;

@end
