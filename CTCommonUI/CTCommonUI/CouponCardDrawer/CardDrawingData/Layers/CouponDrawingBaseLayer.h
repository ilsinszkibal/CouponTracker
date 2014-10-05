//
//  CouponDrawingBaseLayer.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CouponDrawingLayerTypes.h"

@interface CouponDrawingBaseLayer : NSObject

@property (nonatomic, readonly) CouponDrawingLayerTypes layerType;

@property (nonatomic, strong) UIImage* renderedImage;
@property (nonatomic, assign) BOOL isInvalid;

+ (id) layerFactoryWithType:(CouponDrawingLayerTypes) type  withMaxLayerPositions:(CGSize) maxLayerPositions;

- (instancetype) initWithLayerType:(CouponDrawingLayerTypes) type;

- (BOOL) isNeedRedraw;
- (BOOL) isBoxBaseLayer;

@end
