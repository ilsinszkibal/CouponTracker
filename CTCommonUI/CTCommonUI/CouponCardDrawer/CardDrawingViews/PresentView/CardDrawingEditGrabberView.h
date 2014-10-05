//
//  CardDrawingEditGrabberView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 21/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardDrawingEditGrabberView;

@protocol CardDrawingEditGrabberViewProtocol <NSObject>

- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) grabber:(CardDrawingEditGrabberView*) grabber touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface CardDrawingEditGrabberView : UIView

- (id) initWithFrame:(CGRect)frame withGrabberDelegate:(id<CardDrawingEditGrabberViewProtocol>) grabberDelegate;

@property (nonatomic, weak) id<CardDrawingEditGrabberViewProtocol> grabberDelegate;

@end
