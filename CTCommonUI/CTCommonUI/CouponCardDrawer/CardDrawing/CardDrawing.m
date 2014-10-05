//
//  CardDrawing.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawing.h"

#import "CouponDrawingData.h"

#import "CouponDrawingImageLayer.h"
#import "CouponDrawingRectLayer.h"
#import "CouponDrawingTextLayer.h"

@interface CardDrawing () {
    
    CGContextRef _sessionContext;
    CGSize _sessionContextSize;
    
}

@end

@implementation CardDrawing

#pragma mark - Basic Drawing operations

- (void) setFillColor:(UIColor*) color
{
    CGContextSetFillColorWithColor(_sessionContext, color.CGColor);
}

- (void) drawRect:(CGRect) rect
{
    CGContextFillRect(_sessionContext, rect );
}

- (void) drawImage:(UIImage*) image inRect:(CGRect) rect
{
    [image drawInRect:rect];
}

- (void) startDrawingSessionWithSize:(CGSize) size fillAllRect:(UIColor*) fillColor
{
    
    _sessionContextSize = size;
    
    double resolution = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(_sessionContextSize, fillColor != nil, resolution );
    
    _sessionContext = UIGraphicsGetCurrentContext();
    
    //Draw full rect
    if ( fillColor )
    {
        [self setFillColor:fillColor ];
        
        CGRect fullRect = CGRectMake(0, 0, _sessionContextSize.width, _sessionContextSize.height);
        [self drawRect:fullRect];
    }
    else
    {
        [self setFillColor:[UIColor whiteColor] ];
    }
    
    
}

- (UIImage*) endDrawingSession
{
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _sessionContext = NULL;
    
    return image;
}

#pragma mark - Layer Drawing operations

- (void) drawRectLayer:(CouponDrawingRectLayer*) rectLayer withSize:(CGSize) size
{
    
    if ( [rectLayer isNeedRedraw] == NO )
        return;
    
    [self startDrawingSessionWithSize:size fillAllRect:nil ];
    [self setFillColor:[rectLayer rectColor] ];
    [self drawRect:[rectLayer layerFrame] ];
    
    [rectLayer setRenderedImage:[self endDrawingSession] ];
    
}

- (void) drawImageLayer:(CouponDrawingImageLayer*) imageLayer withSize:(CGSize) size
{
    
    if ( [imageLayer isNeedRedraw] == NO )
        return;
    
    [self startDrawingSessionWithSize:size fillAllRect:nil];
    UIImage* image = [imageLayer originalImage];
    [image drawInRect:[imageLayer layerFrame] ];
    
    [imageLayer setRenderedImage:[self endDrawingSession] ];
}

- (void) drawTextLayer:(CouponDrawingTextLayer*) textLayer withSize:(CGSize) size
{
    
    if ( [textLayer isNeedRedraw] == NO )
        return;
    
    [self startDrawingSessionWithSize:size fillAllRect:nil];
    NSAttributedString* drawString = [[NSAttributedString alloc] initWithString:textLayer.text attributes:[textLayer attributedDictionary] ];
    [drawString drawAtPoint:[textLayer position] ];
    
    [textLayer setRenderedImage:[self endDrawingSession] ];
}

- (void) drawLayer:(CouponDrawingBaseLayer*) baseLayer withSize:(CGSize) size
{
    if ( baseLayer == nil )
        return;
    
    switch ( [baseLayer layerType] ) {
        case CouponDrawingLayerTypeImage:
            [self drawImageLayer:(CouponDrawingImageLayer*)baseLayer withSize:size];
            break;
            
        case CouponDrawingLayerTypeRect:
            [self drawRectLayer:(CouponDrawingRectLayer*)baseLayer withSize:size];
            break;
            
        case CouponDrawingLayerTypeText:
            [self drawTextLayer:(CouponDrawingTextLayer*)baseLayer withSize:size];
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Draw card with Render Images

- (UIImage*) drawCardImageFromRenderedImages:(CouponDrawingData*) drawingData withSize:(CGSize) size
{
    
    [self startDrawingSessionWithSize:size fillAllRect:[UIColor whiteColor] ];
    
    CGRect fullRect = CGRectZero;
    fullRect.size = size;
    for (NSUInteger layerIndex = 0; layerIndex < [drawingData layerCount]; layerIndex++)
    {
        UIImage* renderedImage = [[drawingData layerAtIndex:layerIndex] renderedImage];
        if ( renderedImage )
        {
            [self drawImage:renderedImage inRect:fullRect ];
        }
    }
   
    return [self endDrawingSession];
}

#pragma mark - Public

- (UIImage*) drawCard:(CouponDrawingData*) couponDrawingData withSize:(CGSize) size
{
    for (NSUInteger layerIndex = 0; layerIndex < [couponDrawingData layerCount]; layerIndex++)
        [self drawLayer:[couponDrawingData layerAtIndex:layerIndex] withSize:size ];
    
    return [self drawCardImageFromRenderedImages:couponDrawingData withSize:size];
}
- (void) drawSingleLayerInSession:(CouponDrawingBaseLayer*) layer withSize:(CGSize)size
{
    [self drawLayer:layer withSize:size];
}

@end
