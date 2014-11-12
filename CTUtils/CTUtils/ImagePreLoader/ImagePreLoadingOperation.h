//
//  ImagePreLoadingOperation.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePreLoading.h"

#import "ImagePreLoadImageInfo.h"

@interface ImagePreLoadingOperation : NSObject

@property (nonatomic, weak, readonly) id<ImagePreLoading> imagePreLoading;
@property (nonatomic, readonly) NSArray* imageUrls;
@property (nonatomic, readonly) NSString* key;

@property (nonatomic, assign) NSUInteger actImageUrlIndex;


@property (nonatomic, readonly) NSMutableArray* imagePreLoadImageInfos;

+ (instancetype) createImagePreLoadingOperation:(NSArray*) imageURLS withImagePreLoading:(id<ImagePreLoading>) imagePreLoading forKey:(NSString*) key;

- (BOOL) hasImageIndex:(NSUInteger) index;
- (NSURL*) urlForIndex:(NSUInteger) index;

- (void) addImagePreLoadingImageInfos:(ImagePreLoadImageInfo*) imageInfo;


@end
