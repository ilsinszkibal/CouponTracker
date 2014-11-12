//
//  ImagePreLoadingOperation.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ImagePreLoadingOperation.h"

@interface ImagePreLoadingOperation ()

@property (nonatomic, weak) id<ImagePreLoading> imagePreLoading;
@property (nonatomic, strong) NSArray* imageUrls;
@property (nonatomic, strong) NSString* key;

@end

@implementation ImagePreLoadingOperation

#pragma mark - Init and Factory

+ (instancetype) createImagePreLoadingOperation:(NSArray*) imageURLS withImagePreLoading:(id<ImagePreLoading>) imagePreLoading forKey:(NSString *)key
{
    
    if ( [imageURLS count] == 0 || imagePreLoading == nil || [key length] == 0 )
        return nil;
    
    ImagePreLoadingOperation* operation = [[ImagePreLoadingOperation alloc] init];
    
    operation.imageUrls = imageURLS;
    operation.imagePreLoading = imagePreLoading;
    operation.key = key;
    
    return operation;
}

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        _imagePreLoadImageInfos = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Public

- (BOOL) hasImageIndex:(NSUInteger) index
{
    return index < [_imageUrls count];
}

- (NSURL*) urlForIndex:(NSUInteger) index
{
    
    if ( index < [_imageUrls count] )
    {
        return _imageUrls[ index ];
    }
    
    return nil;
}

- (void) addImagePreLoadingImageInfos:(ImagePreLoadImageInfo*) imageInfo
{
    if ( imageInfo )
    {
        [_imagePreLoadImageInfos addObject:imageInfo];
    }
}

@end
