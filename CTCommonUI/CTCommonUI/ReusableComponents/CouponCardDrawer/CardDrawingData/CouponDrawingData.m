//
//  CouponDrawingData.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingData.h"

#import "CouponDrawingBaseLayer.h"

@interface CouponDrawingData () {
    
    NSMutableArray* _layers;
    
}

@end

@implementation CouponDrawingData

#pragma mark - Init

- (instancetype) init
{
    self = [self initWithMaxNbOfLayers:5];
    return self;
}

- (instancetype) initWithMaxNbOfLayers:(NSUInteger) maxNbOfLayers
{
    
    self = [super init];
    
    if ( self ) {
        _maxNbOfLayers = maxNbOfLayers;
        
        _layers = [[NSMutableArray alloc] initWithCapacity:_maxNbOfLayers];
        
    }
    
    return self;
}

#pragma mark - Public

- (BOOL) canAddMoreLayers
{
    return [self layerCount] != _maxNbOfLayers;
}

- (NSUInteger) layerCount
{
    return [_layers count];
}

- (CouponDrawingBaseLayer*) layerAtIndex:(NSUInteger) index
{
    
    if ( [_layers count] <= index )
        return nil;
    
    return [_layers objectAtIndex:index];
}

- (CouponDrawingBaseLayer*) layerAtIndex:(NSUInteger)index withType:(CouponDrawingLayerTypes) type
{
    CouponDrawingBaseLayer* layer = [self layerAtIndex:index];
    
    if ( [layer layerType] == type )
        return layer;
    
    return nil;
}

- (void) addLayer:(CouponDrawingBaseLayer*) layer AtIndex:(NSUInteger) index
{
    
    if ( [_layers count] == _maxNbOfLayers || layer == nil )
        return;
    
    index = [self validIndex:index];
    
    [_layers insertObject:layer atIndex:index];
    
}

- (CouponDrawingBaseLayer*) removeLayerAtIndex:(NSUInteger) index
{
    CouponDrawingBaseLayer* layer = [self layerAtIndex:index];
    
    if ( layer ) {
        [_layers removeObject:layer];
    }
    
    return layer;
}

#pragma mark - Private

- (NSUInteger) validIndex:(NSUInteger) index
{
    
    if ( [_layers count] <= index )
        return [_layers count];
    
    return 0;
}

@end
