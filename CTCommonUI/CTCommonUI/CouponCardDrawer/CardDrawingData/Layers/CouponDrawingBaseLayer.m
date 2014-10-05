//
//  CouponDrawingBaseLayer.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBaseLayer.h"

#import "CouponDrawingRectLayer.h"
#import "CouponDrawingImageLayer.h"
#import "CouponDrawingTextLayer.h"

@implementation CouponDrawingBaseLayer

#pragma mark - Factory

+ (id) layerFactoryWithType:(CouponDrawingLayerTypes) type  withMaxLayerPositions:(CGSize) maxLayerPositions
{
    
    switch ( type ) {
        default:
        case CouponDrawingLayerTypeRect:
            return [[CouponDrawingRectLayer alloc] initWithSelectedColorIndex:0 withMaxLayerPositions:maxLayerPositions];
            break;
            
        case CouponDrawingLayerTypeImage:
            return [[CouponDrawingImageLayer alloc] initWithOriginalImage:[UIImage imageNamed:@"defaultDrawing"] withMaxLayerPositions:maxLayerPositions];
            break;
            
        case CouponDrawingLayerTypeText:
            return [[CouponDrawingTextLayer alloc] initWithText:@"Text" textColorIndex:0 fontSizeIndex:0 withMaxLayerPositions:maxLayerPositions];
            break;
            
    }
    
    return nil;
}

#pragma mark - Init

- (instancetype) initWithLayerType:(CouponDrawingLayerTypes)type
{
    
    self = [super init];
    
    if ( self ) {
        _layerType = type;
    }
    
    return self;
}

#pragma mark - Draw

- (BOOL) isNeedRedraw
{
    return _renderedImage == nil || _isInvalid;
}

- (BOOL) isBoxBaseLayer
{
    return [self isKindOfClass:[CouponDrawingBoxBaseLayer class] ];
}
            
#pragma mark - property

- (void) setRenderedImage:(UIImage *)renderedImage
{
    _renderedImage = renderedImage;
    _isInvalid = NO;
}

@end