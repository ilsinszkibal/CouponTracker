//
//  CouponDrawingRectLayer.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBoxBaseLayer.h"

@interface CouponDrawingRectLayer : CouponDrawingBoxBaseLayer

@property (nonatomic, readonly) NSUInteger selectedColorIndex;

- (instancetype) initWithSelectedColorIndex:(NSUInteger) selectedColorIndex withMaxLayerPositions:(CGSize) maxLayerPositions;

+ (NSInteger) maxNumberOfRectIndex;
+ (UIColor*) colorForRectIndex:(NSUInteger) rectIndex;

- (void) setSelectedColorIndex:(NSUInteger)selectedColorIndex;
- (UIColor*) rectColor;

@end
