//
//  CardDrawingOperationTextEditView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardDrawingOperationEditProtocol.h"

@class CouponDrawingTextLayer;

@interface CardDrawingOperationTextEditView : UIView

@property (nonatomic, weak) id<CardDrawingOperationEditProtocol> editDelegate;

- (void) editTextLayer:(CouponDrawingTextLayer*) rectLayer forIndex:(NSUInteger) index;

@end
