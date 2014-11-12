//
//  ImagePreLoadImageInfo.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ImagePreLoadImageInfo.h"

@interface ImagePreLoadImageInfo ()

@property (nonatomic, strong) NSURL* url;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) ImageInfoState imageInfoState;

@end

@implementation ImagePreLoadImageInfo

+ (instancetype) createImageInfo:(NSURL*) url withImage:(UIImage*) image
{
    
    if ( url == nil || image == nil )
        return nil;
    
    ImagePreLoadImageInfo* imageInfo = [[ImagePreLoadImageInfo alloc] init];
    
    imageInfo.url = url;
    imageInfo.imageSize = image.size;
    imageInfo.imageInfoState = ImageInfoStateMeasured;
    
    return imageInfo;
}

+ (instancetype) createFailedImageInfo:(ImageInfoState) state
{
    ImagePreLoadImageInfo* imageInfo = [[ImagePreLoadImageInfo alloc] init];
    
    if ( state != ImageInfoStateMeasured )
    {
        imageInfo.imageInfoState = state;
    }
    
    return imageInfo;
}

@end
