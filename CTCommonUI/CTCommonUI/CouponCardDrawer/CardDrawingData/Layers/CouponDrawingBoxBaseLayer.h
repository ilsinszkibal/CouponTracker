//
//  CouponDrawingBoxBaseLayer.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBaseLayer.h"

@interface CouponDrawingBoxBaseLayer : CouponDrawingBaseLayer

@property (nonatomic, readonly) CGRect layerFrame;
@property (nonatomic, readonly) CGSize maxLayerPositions;


- (instancetype) initWithLayerType:(CouponDrawingLayerTypes) type withMaxLayerPositions:(CGSize) maxLayerPositions;

- (void) setLayerFrame:(CGRect) layerFrame;

@end
