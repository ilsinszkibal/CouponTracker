//
//  CouponDrawingImageLayer.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingBoxBaseLayer.h"

@interface CouponDrawingImageLayer : CouponDrawingBoxBaseLayer

@property (nonatomic, strong) UIImage* originalImage;

- (instancetype) initWithOriginalImage:(UIImage*) image withMaxLayerPositions:(CGSize) maxLayerPositions;

@end
