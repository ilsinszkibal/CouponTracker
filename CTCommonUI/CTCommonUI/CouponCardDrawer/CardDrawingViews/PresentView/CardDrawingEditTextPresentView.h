//
//  CardDrawingEditTextPresentView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardDrawingEditGrabberView.h"

#import "CardDrawingEditPresentViewProtocol.h"

@class CouponDrawingTextLayer;

@interface CardDrawingEditTextPresentView : UIView<CardDrawingEditGrabberViewProtocol>

@property (nonatomic, weak) id<CardDrawingEditPresentViewProtocol> editProtocol;

- (void) startEditingBoxLayer:(CouponDrawingTextLayer*) textLayer;
- (void) commitLayerEdit;

- (void) reset;

@end
