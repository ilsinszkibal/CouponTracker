//
//  CardDrawingEditPresentView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 21/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingEditBoxPresentView.h"

#import "CardDrawingEditGrabberView.h"

@interface CardDrawingEditBoxPresentView () {
    
    CouponDrawingBoxBaseLayer* _boxLayer;
    
    CardDrawingEditGrabberView* _topLeftGrabber;
    CardDrawingEditGrabberView* _bottomRightGrabber;
    
}

@end

@implementation CardDrawingEditBoxPresentView

#pragma mark - Init

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        [self setBackgroundColor:[UIColor clearColor] ];
        
        _topLeftGrabber = [[CardDrawingEditGrabberView alloc] initWithFrame:CGRectMake(0, 0, 30, 30) withGrabberDelegate:self ];
        [_topLeftGrabber setAlpha:0.5];
        [self addSubview:_topLeftGrabber];
        _bottomRightGrabber = [[CardDrawingEditGrabberView alloc] initWithFrame:CGRectMake(0, 0, 30, 30) withGrabberDelegate:self ];
        [_bottomRightGrabber setAlpha:0.5];
        [self addSubview:_bottomRightGrabber];
        
    }
    
    return self;
}

#pragma mark - CardDrawingEditGrabberViewProtocol

- (void) grabber:(CardDrawingEditGrabberView *)grabber touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) grabber:(CardDrawingEditGrabberView *)grabber touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) grabber:(CardDrawingEditGrabberView *)grabber touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateEditingLayerFrame];
}

- (void) grabber:(CardDrawingEditGrabberView *)grabber touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    CGPoint touchAt = [[touches anyObject] locationInView:self];
    
    if ( grabber == _topLeftGrabber )
    {
        [self moveTopLeftGrabber:touchAt];
    }
    else
    {
        [self moveBottomRightGrabber:touchAt];
    }
    
}

#pragma mark - Private moving grabbers

- (void) moveBottomRightGrabber:(CGPoint) touchAt
{
    if ( touchAt.x < CGRectGetMaxX( _topLeftGrabber.frame ) )
        touchAt.x = CGRectGetMaxX( _topLeftGrabber.frame );
    
    if ( touchAt.y < CGRectGetMaxY( _topLeftGrabber.frame ) )
        touchAt.y = CGRectGetMaxY( _topLeftGrabber.frame );
    
    
    CGRect frame = [_bottomRightGrabber frame];
    frame.origin = touchAt;
    
    //Bottom right need to stay in view's bounds
    if ( CGRectGetMaxX( self.frame ) < CGRectGetMaxX( frame ) )
        frame.origin.x = CGRectGetMaxX( self.frame ) - frame.size.width;
    
    if ( CGRectGetMaxY( self.frame ) < CGRectGetMaxY( frame ) )
        frame.origin.y = CGRectGetMaxY( self.frame ) - frame.size.height;
    
    [_bottomRightGrabber setFrame:frame];
    
}

- (void) moveTopLeftGrabber:(CGPoint) touchAt
{
    
    //Top Left needs to stay in view's bounds
    if ( touchAt.x < 0 )
        touchAt.x = 0;
    
    if ( touchAt.y < 0 )
        touchAt.y = 0;
    
    CGFloat maxValidX = self.width - _bottomRightGrabber.width - _topLeftGrabber.width;
    if ( maxValidX < touchAt.x )
        touchAt.x = maxValidX;
    
    CGFloat maxValidY = self.height - _bottomRightGrabber.height - _topLeftGrabber.height;
    if ( maxValidY < touchAt.y )
        touchAt.y = maxValidY;
    
    CGRect frame = [_topLeftGrabber frame];
    CGPoint originalPoint = frame.origin;
    frame.origin = touchAt;
    
    [_topLeftGrabber setFrame:frame];
    
    //Move bottom with difference
    CGPoint bottomOrigin = _bottomRightGrabber.frame.origin;
    bottomOrigin.x += ( frame.origin.x - originalPoint.x );
    bottomOrigin.y += ( frame.origin.y - originalPoint.y );
    [self moveBottomRightGrabber:bottomOrigin];
    
    
}

- (void) checkRelativePositionBetweenGrabbers
{
    
    CGRect topLeftFrame = [_topLeftGrabber frame];
    CGRect bottomRightFrame = [_bottomRightGrabber frame];
    
    //Too close to each other
    if ( bottomRightFrame.origin.x < CGRectGetMaxX( topLeftFrame ) )
        bottomRightFrame.origin.x = CGRectGetMaxX( topLeftFrame );
    
    if ( bottomRightFrame.origin.y < CGRectGetMaxY( topLeftFrame ) )
        bottomRightFrame.origin.y = CGRectGetMaxY( topLeftFrame );
    
}

#pragma mark - Private editing frames

- (void) updateEditingLayerFrame
{
    
    CGPoint topLeft = [_topLeftGrabber frame].origin;
    CGPoint bottomRight = CGPointMake( CGRectGetMaxX( _bottomRightGrabber.frame ) , CGRectGetMaxY( _bottomRightGrabber.frame ) );
    
    CGRect newLayerFrame;
    newLayerFrame.origin = topLeft;
    newLayerFrame.size.width = bottomRight.x - topLeft.x;
    newLayerFrame.size.height = bottomRight.y - topLeft.y;
    
    [_boxLayer setLayerFrame:newLayerFrame];
    [_editProtocol layerPositionChanged];
    
    [self setTopLeftGrabberPosition:[_boxLayer layerFrame] ];
    [self setBottomRightGrabberPosition:[_boxLayer layerFrame] ];
    
}

- (void) setTopLeftGrabberPosition:(CGRect) layerRect
{
    
    CGRect topLeft = [_topLeftGrabber frame];
    topLeft.origin = layerRect.origin;
    
    [_topLeftGrabber setFrame:topLeft];
}

- (void) setBottomRightGrabberPosition:(CGRect) layerRect
{
    
    CGRect bottomRight = [_bottomRightGrabber frame];
    bottomRight.origin.x = CGRectGetMaxX( layerRect ) - bottomRight.size.width;
    bottomRight.origin.y = CGRectGetMaxY( layerRect ) - bottomRight.size.height;
    
    [_bottomRightGrabber setFrame:bottomRight];
}

#pragma mark - Public

- (void) startEditingBoxLayer:(CouponDrawingBoxBaseLayer*) boxLayer
{
    _boxLayer = boxLayer;
    
    [self setTopLeftGrabberPosition:[_boxLayer layerFrame] ];
    [self setBottomRightGrabberPosition:[_boxLayer layerFrame] ];
    
}

- (void) commitLayerEdit
{
    [self setTopLeftGrabberPosition:[_boxLayer layerFrame] ];
    [self setBottomRightGrabberPosition:[_boxLayer layerFrame] ];
}

- (void) reset
{
    _boxLayer = nil;
}

@end
