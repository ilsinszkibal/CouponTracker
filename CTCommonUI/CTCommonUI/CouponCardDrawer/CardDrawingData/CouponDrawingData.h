//
//  CouponDrawingData.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CouponDrawingLayerTypes.h"

typedef enum : NSUInteger {
    CouponDrawingStateUnkown = 0,
    CouponDrawingStatePresent,
    CouponDrawingStateDraw,
    CouponDrawingStateEdit,
    CouponDrawingStateCommitEdit,
    CouponDrawingStateLayerCandidate
} CouponDrawingState;

@class CouponDrawingBaseLayer;

@interface CouponDrawingData : NSObject

//Current operation state
@property (nonatomic, assign) CouponDrawingState state;
@property (nonatomic, assign) NSUInteger layerIndex;

//Card image
@property (nonatomic, strong) UIImage* cardImage;


@property (nonatomic, readonly) NSUInteger maxNbOfLayers;
@property (nonatomic, readonly) NSUInteger nbOfLayers;

- (instancetype) initWithMaxNbOfLayers:(NSUInteger) maxNbOfLayers;

- (BOOL) canAddMoreLayers;

- (NSUInteger) layerCount;
- (CouponDrawingBaseLayer*) layerAtIndex:(NSUInteger) index;
- (CouponDrawingBaseLayer*) layerAtIndex:(NSUInteger)index withType:(CouponDrawingLayerTypes) type;
- (void) addLayer:(CouponDrawingBaseLayer*) layer AtIndex:(NSUInteger) index;
- (CouponDrawingBaseLayer*) removeLayerAtIndex:(NSUInteger) index;

@end
