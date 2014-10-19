//
//  NSDictionary+extractValue.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import "NSDictionary+extractValue.h"
#import "TMDBDebug.h"

#import "TMDBGenre.h"
#import "TMDBKeyword.h"
#import "TMDBCompany.h"
#import "TMDBPromisedPerson.h"
#import "TMDBPromisedTVSeason.h"

@implementation NSDictionary (NSDictionary_extractValue)

- (id)extractValueforKey:(NSString*)aKey ifClass:(Class)aType {
    //TMDBLog(@"%s %@ %@", __FUNCTION__, aKey, aType);
    
    
    id obj;
    if ((obj = [self valueForKey:aKey])) {
        
        if (aType == [NSString class]) {
            if ([obj isKindOfClass:[NSString class]]) {
                TMDBLog(@"set %@ to %@", aKey, obj);
                return obj;
            }
        }
        else if (aType == [NSNumber class]) {
            if ([obj isKindOfClass:[NSNumber class]]) {
                return obj;
            }
        }
        else if (aType == [NSArray class]) {
            if ([obj isKindOfClass:[NSArray class]]) {
                if ([aKey isEqualToString:@"created_by"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractPersonsfromArray:(NSArray *)obj];
                }
                else if ([aKey isEqualToString:@"genres"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractGenresfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"episode_run_time"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractRuntimefromArray:(NSArray *)obj];
                }
                else if ([aKey isEqualToString:@"images"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    
                }
                else if ([aKey isEqualToString:@"keywords"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractKeywordsfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"languages"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    
                }
                else if ([aKey isEqualToString:@"networks"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractCompaniesfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"origin_country"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    
                }
                else if ([aKey isEqualToString:@"production_companies"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractCompaniesfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"seasons"]) {
                    TMDBLog(@"set %@ to %@", aKey, obj);
                    //return [[NSArray alloc] initWithArray:(NSArray *)obj copyItems:YES];
                    return [self extractSeasonfromArray:(NSArray *)obj];
                }
                return [obj copy];
            }
        }
        else if (aType == [NSDate class]) {
            if ([obj isKindOfClass:[NSString class]]) {
                TMDBLog(@"set %@ to %@", aKey, obj);
                return [self extractDatefromString:(NSString*)obj];
            }
            //return obj;
        }
        else if (aType == [NSURL class]) {
            if ([obj isKindOfClass:[NSURL class]]) {
                TMDBLog(@"set %@ to %@", aKey, obj);
                return [obj copy];
            }
            if ([obj isKindOfClass:[NSString class]]) {
                TMDBLog(@"set %@ to %@", aKey, obj);
                return [NSURL URLWithString:(NSString *)obj];
            }
            //return obj;
        }
        else if ([obj isKindOfClass:[NSNull class]]) {
            TMDBLog(@"set %@ to %@", aKey, obj);
            return obj;
        }
    }
    return nil;
}

-(NSDate*)extractDatefromString:(NSString*)aString {
    NSDate* new_date = nil;
    NSDateComponents *date = [[NSDateComponents alloc] init];
    NSArray *components = [aString componentsSeparatedByString:@"-"];
    if ([components count] == 3) {
        [date setYear:[[components objectAtIndex:0] intValue]];
        [date setMonth:[[components objectAtIndex:1] intValue]];
        [date setDay:[[components objectAtIndex:2] intValue]];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        new_date = [cal dateFromComponents:date];
    }
    return new_date;
}

-(NSArray*)extractGenresfromArray:(NSArray*)anArr {
    NSArray* new_array = nil;
    NSMutableArray *newGenres = [NSMutableArray array];
    for (NSDictionary *key in anArr) {
        if (![[key valueForKey:@"id"] isMemberOfClass:[NSNull class]]) {
            [newGenres addObject:[TMDBGenre genreWithID:[[key valueForKey:@"id"] intValue] andName:[key valueForKey:@"name"]]];
        }
    }
    new_array = [NSArray arrayWithArray:newGenres];
    return new_array;
}

-(NSArray*)extractKeywordsfromArray:(NSArray*)anArr {
    NSArray* new_array = nil;
    NSMutableArray *newKeywords = [NSMutableArray array];
    for (NSDictionary *key in [[anArr valueForKey:@"results"] copy]) {
        [newKeywords addObject:[TMDBKeyword keywordWithID:[[key valueForKey:@"id"] intValue] andName:[key valueForKey:@"name"]]];
    }
    new_array = [NSArray arrayWithArray:newKeywords];
    return new_array;
}

-(NSArray*)extractCompaniesfromArray:(NSArray*)anArr {
    NSArray* new_array = nil;
    NSMutableArray *newStudios = [NSMutableArray array];
    for (NSDictionary *key in anArr) {
        if (![[key valueForKey:@"name"] isMemberOfClass:[NSNull class]]) {
            [newStudios addObject:[TMDBCompany companyWithName:key[@"name"] andIdentifier:[NSNumber numberWithInt:(int)key[@"id"]]]];
        }
    }
    new_array = [NSArray arrayWithArray:newStudios];
    return new_array;
}

-(NSArray*)extractPersonsfromArray:(NSArray*)anArr {
    NSArray* new_array = nil;
    NSMutableArray *newPersons = [NSMutableArray array];
    for (NSDictionary *key in anArr) {
        if (![[key valueForKey:@"name"] isMemberOfClass:[NSNull class]]) {
            [newPersons addObject:[[TMDBPromisedPerson alloc] initWithPersonInfo:key]];
        }
    }
    new_array = [NSArray arrayWithArray:newPersons];
    return new_array;
}

-(NSNumber*)extractRuntimefromArray:(NSArray*)anArr {
    NSNumber* new_number = nil;
    if ([anArr count] > 0) {
        int value = 0;
        for (NSNumber* num in anArr) {
            value += [num intValue];
        }
        new_number = [NSNumber numberWithInt:(value / [anArr count])];
    }
    return new_number;
}

-(NSArray*)extractSeasonfromArray:(NSArray*)anArr {
    NSArray* new_array = nil;
    NSMutableArray *newSeasons = [NSMutableArray array];
    for (NSDictionary *key in anArr) {
        if (![[key valueForKey:@"season_number"] isMemberOfClass:[NSNull class]]) {
            TMDBPromisedTVSeason* season = [TMDBPromisedTVSeason promisedTVSeasonFromDictionary:key withContext:nil];
            if (![[self valueForKey:@"id"] isMemberOfClass:[NSNull class]]) {
                [season setParentID:[self objectForKey:@"id"]];
            }
            [newSeasons addObject:season];
        }
    }
    new_array = [NSArray arrayWithArray:newSeasons];
    return new_array;
}
/*NSMutableArray *newLanguages = [NSMutableArray array];
 for (NSDictionary *key in [_rawResults valueForKey:@"languages"]) {
 if (![[key valueForKey:@"name"] isMemberOfClass:[NSNull class]]) {
 [newLanguages addObject:[TMDBLanguage languageWithName:key[@"name"] andISOCode:key[@"iso_639_1"]]];
 }
 }
 _languages = [newLanguages copy];*/
/*NSMutableArray *newCountries = [NSMutableArray array];
 for (NSDictionary *key in [[_rawResults valueForKey:@"origin_country"] copy]) {
 if ([[key valueForKey:@"iso_3166_1"] isMemberOfClass:[NSNull class]]) {
 [newCountries addObject:[TMDBCountry countryWithISOCode:[key valueForKey:@"iso_3166_1"] andName:[key valueForKey:@"name"]]];
 }
 }
 _origin_country = [newCountries copy];*/
/*
 _backdrops = [[[_rawResults valueForKey:@"images"] valueForKey:@"backdrops"] copy];
 _posters = [[[_rawResults valueForKey:@"images"] valueForKey:@"posters"] copy];
 */


@end