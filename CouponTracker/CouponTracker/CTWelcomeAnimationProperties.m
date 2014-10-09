//
//  CTWelcomeAnimationProperties.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTWelcomeAnimationProperties.h"

@implementation CTWelcomeAnimationProperties

#pragma mark - Factory method

+ (instancetype) createOpeningAnimationForImageSize:(CGSize) imageSize
{
    
    CGPoint preAnimationOffset;
    CGPoint postAnimationOffset;
    
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
    {
        preAnimationOffset = CGPointMake(-480, 0);
        postAnimationOffset = CGPointMake(-450, 0);
        
        imageSize.width *= 0.4;
        imageSize.height *= 0.4;
    }
    else
    {
        preAnimationOffset = CGPointMake(-430, 0);
        postAnimationOffset = CGPointMake(-400, 0);
        
        imageSize.width *= 0.6;
        imageSize.height *= 0.6;
    }
    
    CTWelcomeAnimationProperties* animation = [[CTWelcomeAnimationProperties alloc] initWithImageSize:imageSize preAnimationOffset:preAnimationOffset postAnimationOffset:postAnimationOffset ];

    return animation;
}

#pragma mark - Init

- (id) initWithImageSize:(CGSize) imageSize preAnimationOffset:(CGPoint) preAnimationOffset postAnimationOffset:(CGPoint) postAnimationOffset
{
    self = [super init];
    
    if ( self ) {
        
        _imageSize = imageSize;
        _preAnimationOffset = preAnimationOffset;
        _postAnimationOffset = postAnimationOffset;
        
    }
    
    return self;
}

#pragma mark - Public

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize
{
    CGRect rect = CGRectZero;
    rect.origin = _preAnimationOffset;
    rect.size = _imageSize;
    
    return rect;
}

- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize
{
    CGRect rect = CGRectZero;
    rect.origin = _postAnimationOffset;
    rect.size = _imageSize;
    
    return rect;
}

@end
