//
//  NSDictionary+extractValue.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2014 Apoltix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_extractValue)

- (id)extractValueforKey:(NSString*)aKey ifClass:(Class)aType;

@end