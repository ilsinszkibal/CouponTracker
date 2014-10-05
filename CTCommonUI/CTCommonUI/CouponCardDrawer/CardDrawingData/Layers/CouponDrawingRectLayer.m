//
//  CouponDrawingRectLayer.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingRectLayer.h"

@interface CouponDrawingRectLayer () {
    
    NSUInteger _maxColorIndex;
    
}

@end

@implementation CouponDrawingRectLayer

#pragma mark - Init

- (instancetype) initWithSelectedColorIndex:(NSUInteger) selectedColorIndex withMaxLayerPositions:(CGSize) maxLayerPositions
{
    
    self = [super initWithLayerType:CouponDrawingLayerTypeRect withMaxLayerPositions:maxLayerPositions];
    
    if ( self ) {
        
        _maxColorIndex = [CouponDrawingRectLayer maxNumberOfRectIndex];
        
        [self setSelectedColorIndex:selectedColorIndex];
    }
    
    return self;
}

#pragma mark - Private

- (NSUInteger) validateColorIndex:(NSUInteger) index
{
    
    if (_maxColorIndex < index )
        return _maxColorIndex;
    
    return index;
}

#pragma mark - Public

+ (NSInteger) maxNumberOfRectIndex
{
    return 5;
}

+ (UIColor*) colorForRectIndex:(NSUInteger) rectIndex
{
    
    switch ( rectIndex ) {
        default:
        case 0:
            return [UIColor whiteColor];
            break;
            
        case 1:
            return [UIColor greenColor];
            break;
            
        case 2:
            return [UIColor purpleColor];
            break;
            
        case 3:
            return [UIColor blueColor];
            break;
            
        case 4:
            return [UIColor blackColor];
            break;
    }
    
}

- (void) setSelectedColorIndex:(NSUInteger) index
{
    if (_maxColorIndex < index )
        index = _maxColorIndex;
    
    _selectedColorIndex = index;
}

- (UIColor*) rectColor
{
    return [CouponDrawingRectLayer colorForRectIndex:_selectedColorIndex];
}

@end
