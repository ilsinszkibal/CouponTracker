//
//  CardDrawingOperationRectEditView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDrawingOperationEditProtocol.h"

@class CouponDrawingRectLayer;

@interface CardDrawingOperationRectEditView : UIView

@property (nonatomic, weak) id<CardDrawingOperationEditProtocol> editDelegate;

- (void) editRectLayer:(CouponDrawingRectLayer*) rectLayer forIndex:(NSUInteger) index;

@end
