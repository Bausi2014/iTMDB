//
//  TMDBDebug.h
//  iTMDb
//
//  Created by Simon Pascal Baur on 15/10/14.
//  Copyright (c) 2013 Simon Baur. All rights reserved.
//

#ifndef TMDBDebug_h
#define TMDBDebug_h

#define TMDBDebug 1

#if TMDBDebug
#define TMDBLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#define TMDBLog(fmt, ...)
#endif

#endif
