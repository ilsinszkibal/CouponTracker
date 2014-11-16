//
//  CardDrawingEditGrabberView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 21/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingEditGrabberView.h"

@implementation CardDrawingEditGrabberView

- (id) initWithFrame:(CGRect)frame withGrabberDelegate:(id<CardDrawingEditGrabberViewProtocol>) grabberDelegate
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        _grabberDelegate = grabberDelegate;
        
        [self setBackgroundColor:[UIColor greenColor] ];
        
        [self.layer setCornerRadius:5];
        [self.layer setShadowColor:[UIColor grayColor].CGColor ];
        [self.layer setShadowRadius:2];
        
        [self.layer setBorderColor:[UIColor blackColor].CGColor ];
        [self.layer setBorderWidth:2];
        
    }
    
    return self;
}

#pragma mark - Touches

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_grabberDelegate grabber:self touchesBegan:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_grabberDelegate grabber:self touchesCancelled:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_grabberDelegate grabber:self touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_grabberDelegate grabber:self touchesMoved:touches withEvent:event];
}

@end
