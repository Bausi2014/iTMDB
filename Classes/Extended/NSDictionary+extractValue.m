//
//  NSDictionary+extractValue.m
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import "NSDictionary+extractValue.h"

#import "TMDBGenre.h"
#import "TMDBKeyword.h"
#import "TMDBCompany.h"

@implementation NSDictionary (NSDictionary_extractValue)

- (id)extractValueforKey:(NSString*)aKey ifClass:(Class)aType {
    //NSLog(@"%s %@ %@", __FUNCTION__, aKey, aType);
    
    
    id obj;
    if ((obj = [self valueForKey:aKey])) {
        
        if (aType == [NSString class]) {
            if ([obj isMemberOfClass:[NSString class]]) {
                NSLog(@"set %@ to %@", aKey, obj);
                return obj;
            }
        }
        else if (aType == [NSNumber class]) {
            if ([obj isMemberOfClass:[NSNumber class]]) {
                return obj;
            }
        }
        else if (aType == [NSArray class]) {
            if ([obj isMemberOfClass:[NSArray class]]) {
                if ([aKey isEqualToString:@"created_by"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [obj copy];
                }
                else if ([aKey isEqualToString:@"genres"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [self extractGenresfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"images"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [obj copy];
                }
                else if ([aKey isEqualToString:@"keywords"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [self extractKeywordsfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"languages"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [obj copy];
                }
                else if ([aKey isEqualToString:@"networks"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [self extractCompanysfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"origin_country"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [obj copy];
                }
                else if ([aKey isEqualToString:@"production_companies"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [self extractCompanysfromArray:(NSArray*)obj];
                }
                else if ([aKey isEqualToString:@"seasons"]) {
                    NSLog(@"set %@ to %@", aKey, obj);
                    return [obj copy];
                }
                return [obj copy];
            }
        }
        else if (aType == [NSDate class]) {
            if ([obj isMemberOfClass:[NSString class]]) {
                NSLog(@"set %@ to %@", aKey, obj);
                return [self extractDatefromString:(NSString*)obj];
            }
            //return obj;
        }
        else if (aType == [NSURL class]) {
            if ([obj isMemberOfClass:[NSURL class]]) {
                NSLog(@"set %@ to %@", aKey, obj);
                return [obj copy];
            }
            //return obj;
        }
        else if ([obj isMemberOfClass:[NSNull class]]) {
            NSLog(@"set %@ to %@", aKey, obj);
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

-(NSArray*)extractCompanysfromArray:(NSArray*)anArr {
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