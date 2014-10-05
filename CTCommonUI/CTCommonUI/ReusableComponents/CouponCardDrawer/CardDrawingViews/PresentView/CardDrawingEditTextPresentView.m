//
//  CardDrawingEditTextPresentView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingEditTextPresentView.h"

#import "CouponDrawingTextLayer.h"
#import "CardDrawingEditGrabberView.h"

@interface CardDrawingEditTextPresentView () {
    
    CouponDrawingTextLayer* _textLayer;
    
    CardDrawingEditGrabberView* _topLeftGrabber;
}

@end

@implementation CardDrawingEditTextPresentView
#pragma mark - Init

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        [self setBackgroundColor:[UIColor clearColor] ];
        
        _topLeftGrabber = [[CardDrawingEditGrabberView alloc] initWithFrame:CGRectMake(0, 0, 30, 30) withGrabberDelegate:self ];
        [_topLeftGrabber setAlpha:0.5];
        [self addSubview:_topLeftGrabber];
        
    }
    
    return self;
}

#pragma mark - Private

- (void) setTopLeftGrabberPosition:(CGRect) layerRect
{
    
    CGRect topLeft = [_topLeftGrabber frame];
    topLeft.origin = layerRect.origin;
    
    [_topLeftGrabber setFrame:topLeft];
}

#pragma mark - Touches

- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateEditingLayerFrame];
}

- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint touchAt = [[touches anyObject] locationInView:self];
    
    if ( touchAt.x < 0 )
        touchAt.x = 0;
    if ( touchAt.y < 0 )
        touchAt.y = 0;
    
    CGFloat maxValidX = self.frame.size.width - _topLeftGrabber.frame.size.width;
    CGFloat maxValidY = self.frame.size.height - _topLeftGrabber.frame.size.height;
    
    if ( maxValidX < touchAt.x )
        touchAt.x = maxValidX;
    if ( maxValidY < touchAt.y )
        touchAt.y = maxValidY;
    
    CGRect frame = [_topLeftGrabber frame];
    frame.origin = touchAt;
    [_topLeftGrabber setFrame:frame];
    
}

#pragma mark - Private

- (void) updateEditingLayerFrame
{
    
    CGPoint topLeft = [_topLeftGrabber frame].origin;
    
    [_textLayer changePosition:topLeft];
    [_editProtocol layerPositionChanged];
    
    [self setTopLeftGrabberPosition:[_textLayer positionFrame] ];
    
}

#pragma mark - Public

- (void) startEditingBoxLayer:(CouponDrawingTextLayer*) textLayer
{
    _textLayer = textLayer;
    
    [self setTopLeftGrabberPosition:[_textLayer positionFrame] ];
}

- (void) commitLayerEdit
{
    [self setTopLeftGrabberPosition:[_textLayer positionFrame] ];
}

- (void) reset
{
    _textLayer = nil;
}

@end
