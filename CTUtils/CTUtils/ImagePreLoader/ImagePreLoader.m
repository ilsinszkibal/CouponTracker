//
//  ImagePreLoader.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ImagePreLoader.h"

#import <SDWebImageManager.h>

#import "ImagePreLoadingOperation.h"
#import "ImagePreLoadImageInfo.h"

@implementation ImagePreLoader

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    
    return instance;
}

- (void) preloadImages:(NSArray*) imageURLs imagePreLoading:(id<ImagePreLoading>) imagePreLoading forKey:(NSString*) key
{
    
    ImagePreLoadingOperation* operation = [ImagePreLoadingOperation createImagePreLoadingOperation:imageURLs withImagePreLoading:imagePreLoading forKey:key];
    
    if ( operation )
    {
        [self preLoadOperationCycle:operation];
    }
    else
    {
        [[operation imagePreLoading] imagesPreloadedFailedForKey:[operation key] ];
    }
    
}

- (void) preLoadOperationCycle:(ImagePreLoadingOperation*) operation
{
    
    NSUInteger actIndex = [operation actImageUrlIndex];
    
    if ( [operation hasImageIndex:actIndex] == NO )
    {
        [[operation imagePreLoading] imagesPreloadedForKey:[operation key] imageInfo:[operation imagePreLoadImageInfos] ];
        return;
    }
    
    
    NSURL* imageURL = [operation urlForIndex:actIndex];
    
    if ( imageURL == nil || [imageURL isKindOfClass:[NSURL class] ] == NO )
    {
        ImagePreLoadImageInfo* imageInfo = [ImagePreLoadImageInfo createFailedImageInfo:ImageInfoStateNoURL];
        [operation addImagePreLoadingImageInfos:imageInfo];
        [operation setActImageUrlIndex:( actIndex + 1 ) ];
    }
    else
    {
        
        __weak ImagePreLoader* weakSelf = self;
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            ImagePreLoader* strongSelf = weakSelf;
            if ( strongSelf != nil )
            {
                
                ImagePreLoadImageInfo* imageInfo;
                if ( image )
                {
                    imageInfo = [ImagePreLoadImageInfo createImageInfo:imageURL withImage:image];
                }
                else
                {
                    imageInfo = [ImagePreLoadImageInfo createFailedImageInfo:ImageInfoStateDownloadFail];
                }
                
                //Add imageInfo
                [operation addImagePreLoadingImageInfos:imageInfo];
                
                //Preload other image
                [operation setActImageUrlIndex:( actIndex + 1 ) ];
                [strongSelf preLoadOperationCycle:operation];
            }
            
            
        }];
        
    }
    
}

@end
