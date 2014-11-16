//
//  ImagePreLoader.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePreLoading.h"

@interface ImagePreLoader : NSObject

+ (instancetype) sharedInstance;

- (void) preloadImages:(NSArray*) imageURLs imagePreLoading:(id<ImagePreLoading>) imagePreLoading forKey:(NSString*) key;

@end
