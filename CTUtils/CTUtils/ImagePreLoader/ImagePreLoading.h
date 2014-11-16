//
//  ImagePreLoading.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImagePreLoading <NSObject>

- (void) imagesPreloadedForKey:(NSString*) key imageInfo:(NSArray*) imageInfo;
- (void) imagesPreloadedFailedForKey:(NSString *)key;

@end
