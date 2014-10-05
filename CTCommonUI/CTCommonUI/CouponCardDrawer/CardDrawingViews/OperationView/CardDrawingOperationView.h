//
//  CardDrawingOperationView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CouponCardDrawerManagerProtocol.h"
#import "CardDrawingOperationAddView.h"
#import "CardDrawingOperationEditProtocol.h"

@class CouponDrawingData;

@interface CardDrawingOperationView : UIView<CardDrawingOperationAddProtocol, CardDrawingOperationEditProtocol>

- (void) setDrawerListener:(id<CouponCardDrawerManagerProtocol>) drawerListener;
- (void) setDrawingData:(CouponDrawingData*) drawingData;

- (void) updateStateIfNeeded;

@end
