//
//  CouponDrawingImageLayer.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingImageLayer.h"

@implementation CouponDrawingImageLayer

#pragma mark - Init

- (instancetype) initWithOriginalImage:(UIImage*) image withMaxLayerPositions:(CGSize) maxLayerPositions
{
    self = [super initWithLayerType:CouponDrawingLayerTypeImage withMaxLayerPositions:maxLayerPositions];
    
    if ( self ) {
        _originalImage = image;
        
        CGRect imageRect = CGRectZero;
        imageRect.size = [_originalImage size];
        [self setLayerFrame:imageRect];
        
    }
    
    return self;
}

@end
