//
//  TMDBPromisedTVSeason.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Derived from TMDBPromisedMovie.h
//  Created by Alessio Moiso on 14/01/13.
//  Copyright (c) 2013 MrAsterisco. All rights reserved.
//  Modified by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Simon Pascal Baur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDBImageDelegate.h"

@interface TMDBPromisedTVEpisodes : NSObject <TMDBImageDelegate>

/*{
    "air_date": "2008-01-19",
    "crew": [
             {
                 "id": 2483,
                 "credit_id": "52b7029219c29533d00dd2c1",
                 "name": "John Toll",
                 "department": "Camera",
                 "job": "Director of Photography",
                 "profile_path": null
             },
             ],
    "episode_number": 1,
    "guest_stars": [
                    {
                        "id": 92495,
                        "name": "John Koyama",
                        "credit_id": "52542273760ee3132800068e",
                        "character": "Emilio Koyama",
                        "order": 1,
                        "profile_path": "/uh4g85qbQGZZ0HH6IQI9fM9VUGS.jpg"
                    },
                    ],
    "name": "Pilot",
    "overview": "When an unassuming high school chemistry teacher discovers he has a rare form of lung cancer, he decides to team up with a former student and create a top of the line crystal meth in a used RV, to provide for his family once he is gone.",
    "id": 62085,
    "production_code": null,
    "season_number": 1,
    "still_path": "/88Z0fMP8a88EpQWMCs1593G0ngu.jpg",
    "vote_average": 8.5,
    "vote_count": 2
}*/

@property TMDB *context;
@property NSDictionary *rawData;

@property NSNumber *parentID;
@property NSDate *air_date;
@property NSArray *crew;
@property NSNumber *episode_number;
@property NSArray *guest_stars;
@property NSString *name;
@property NSString *overview;
@property NSNumber *identifier;
@property NSNumber *production_code;
@property NSNumber *season_number;
@property NSString *still_path;
@property NSNumber *vote_average;
@property NSNumber *vote_count;

@property NSImage *loadedPoster;
@property TMDBImage *loadingPoster;

+ (TMDBPromisedTVEpisodes*)promisedTVEpisodesFromDictionary:(NSDictionary*)tvEpisodes withContext:(TMDB*)context;
- (id)initWithContentsOfDictionary:(NSDictionary*)tvEpisodes fromContext:(TMDB*)context;

- (void)loadPoster;
- (void)tvEpisodes;

@end
