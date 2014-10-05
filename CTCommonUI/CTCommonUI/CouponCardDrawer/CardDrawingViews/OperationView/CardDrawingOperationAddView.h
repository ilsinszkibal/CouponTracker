//
//  CardDrawingOperationAddView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CouponDrawingLayerTypes.h"

@protocol CardDrawingOperationAddProtocol <NSObject>

- (void) addLayerType:(CouponDrawingLayerTypes) type;

@end

@interface CardDrawingOperationAddView : UIView

@property (nonatomic, weak) id<CardDrawingOperationAddProtocol> addDelegate;

@end
