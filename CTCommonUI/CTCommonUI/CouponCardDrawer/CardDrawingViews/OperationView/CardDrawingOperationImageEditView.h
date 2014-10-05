//
//  CardDrawingOperationImageEditView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 29/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardDrawingOperationEditProtocol.h"

@class CouponDrawingImageLayer;

@interface CardDrawingOperationImageEditView : UIView

@property (nonatomic, weak) id<CardDrawingOperationEditProtocol> editDelegate;

- (void) editRectLayer:(CouponDrawingImageLayer*) rectLayer forIndex:(NSUInteger) index;

@end
