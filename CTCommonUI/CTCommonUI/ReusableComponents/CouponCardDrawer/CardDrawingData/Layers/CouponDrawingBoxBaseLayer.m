//
//  CouponDrawingBoxBaseLayer.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBoxBaseLayer.h"

@interface CouponDrawingBoxBaseLayer () {
    
    CGSize _minimalLayerSize;
    
}

@end

@implementation CouponDrawingBoxBaseLayer

- (instancetype) initWithLayerType:(CouponDrawingLayerTypes) type withMaxLayerPositions:(CGSize) maxLayerPositions
{
    
    self = [super initWithLayerType:type];
    
    if ( self ) {
        _minimalLayerSize = CGSizeMake(70, 70);
        
        _maxLayerPositions = maxLayerPositions;
        
        [self setLayerFrame:CGRectZero];
    }
    
    return self;
}

#pragma mark - Public

- (void) setLayerFrame:(CGRect) layerFrame
{
    //Size to minimal
    if ( layerFrame.size.width < _minimalLayerSize.width )
        layerFrame.size.width = _minimalLayerSize.width;
    
    if ( layerFrame.size.height < _minimalLayerSize.height )
        layerFrame.size.height = _minimalLayerSize.height;
    
    //Positions to in bounds
    if ( layerFrame.origin.x < 0 )
        layerFrame.origin.x = 0;
    
    if ( layerFrame.origin.y < 0 )
        layerFrame.origin.y = 0;
    
    if ( _maxLayerPositions.width < CGRectGetMaxX( layerFrame ) )
        layerFrame.origin.x = _maxLayerPositions.width - layerFrame.size.width;
    
    if ( _maxLayerPositions.height < CGRectGetMaxY( layerFrame ) )
        layerFrame.origin.y = _maxLayerPositions.height - layerFrame.size.height;
    
    _layerFrame = CGRectIntegral( layerFrame );
}

@end
