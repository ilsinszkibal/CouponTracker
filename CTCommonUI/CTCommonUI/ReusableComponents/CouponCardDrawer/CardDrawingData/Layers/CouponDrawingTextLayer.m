//
//  CouponDrawingTextLayer.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponDrawingTextLayer.h"

@interface CouponDrawingTextLayer () {
    
    NSUInteger _maxColorIndex;
    NSUInteger _maxFontSizeIndex;
    
    CGSize _maxLayerPositions;
    CGSize _minimalLayerSize;
}

@end

@implementation CouponDrawingTextLayer

#pragma mark - Init

- (id) initWithText:(NSString*) text textColorIndex:(NSUInteger) textColorIndex fontSizeIndex:(NSUInteger) fontSizeIndex withMaxLayerPositions:(CGSize) maxLayerPositions
{
    
    self = [super initWithLayerType:CouponDrawingLayerTypeText];
    
    if ( self ) {
        
        _text = text;
        _minimalLayerSize = CGSizeMake(70, 70);
        
        _maxFontSizeIndex = [CouponDrawingTextLayer maxNumberOfFontIndex];
        _maxColorIndex = [CouponDrawingTextLayer maxNumberOfColorIndex];
        
        _fontSizeIndex = [self validatedSizeIndex:fontSizeIndex];
        _fontColorIntex = [self validatedColorIndex:textColorIndex];
        
        _maxLayerPositions = maxLayerPositions;
        
        [self changePosition:CGPointZero];
    }
    
    return self;
}

#pragma mark - Private

- (NSUInteger) validatedColorIndex:(NSUInteger) colorIndex
{
    if ( _maxColorIndex < colorIndex )
        return _maxColorIndex;
    
    return colorIndex;
}

- (NSUInteger) validatedSizeIndex:(NSUInteger) sizeIndex
{
    if ( _maxFontSizeIndex < sizeIndex )
        return _maxFontSizeIndex;
    
    return sizeIndex;
}

#pragma mark - Public

+ (NSInteger) maxNumberOfColorIndex
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

+ (NSInteger) maxNumberOfFontIndex
{
    return 5;
}

+ (NSInteger) fontSizeForIndex:(NSUInteger) fontIndex
{
    
    switch ( fontIndex ) {
        default:
        case 0:
            return 22;
            break;
            
        case 1:
            return 28;
            break;
            
        case 2:
            return 34;
            break;
            
        case 3:
            return 40;
            break;
            
        case 4:
            return 48;
            break;
    }
    
}

- (void) setText:(NSString*) text
{
    
    if ( text == nil )
        text = @"";
    
    _text = text;
    [self changePosition:_position];
}


- (void) setFontSizeIndex:(NSUInteger)fontSizeIndex
{
    _fontSizeIndex = [self validatedSizeIndex:fontSizeIndex];
}

- (CGFloat) fontSize
{
    return [CouponDrawingTextLayer fontSizeForIndex:_fontSizeIndex ];
}

- (void) setFontColorIntex:(NSUInteger)fontColorIntex
{
    _fontColorIntex = [self validatedColorIndex:fontColorIntex];
}

- (UIColor*) fontColor
{
    return [CouponDrawingTextLayer colorForRectIndex:_fontColorIntex];
}

- (NSDictionary*) attributedDictionary
{
    NSDictionary* dictionary = @{ NSFontAttributeName : [UIFont systemFontOfSize:[self fontSize] ], NSForegroundColorAttributeName : [self fontColor] };
    return dictionary;
}

- (void) changePosition:(CGPoint) position
{
    if ( position.x < 0 )
        position.x = 0;
    if ( position.y < 0 )
        position.y = 0;
    
    if ( _maxLayerPositions.width < ( position.x + _minimalLayerSize.width ) )
        position.x = _maxLayerPositions.width - _minimalLayerSize.width;
    
    if ( _maxLayerPositions.height < ( position.y + _minimalLayerSize.height ) )
        position.y = _maxLayerPositions.height - _minimalLayerSize.height;
    
    _position = position;
}

- (CGRect) positionFrame
{
    CGRect rect;
    rect.origin = _position;
    rect.size = _minimalLayerSize;
    
    return rect;
}


@end
