//
//  CardDrawingEditPresentView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 21/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardDrawingEditPresentViewProtocol.h"

#import "CouponDrawingBoxBaseLayer.h"
#import "CouponDrawingTextLayer.h"

#import "CardDrawingEditGrabberView.h"

@interface CardDrawingEditBoxPresentView : UIView<CardDrawingEditGrabberViewProtocol>

@property (nonatomic, weak) id<CardDrawingEditPresentViewProtocol> editProtocol;

- (void) startEditingBoxLayer:(CouponDrawingBoxBaseLayer*) boxLayer;
- (void) commitLayerEdit;

- (void) reset;

@end
