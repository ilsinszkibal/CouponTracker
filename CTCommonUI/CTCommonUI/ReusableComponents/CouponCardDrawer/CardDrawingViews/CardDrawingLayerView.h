//
//  CardDrawingLayerView.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CouponCardDrawerManagerProtocol.h"

@class CouponDrawingData;

@interface CardDrawingLayerView : UIView

- (void) setDrawerListener:(id<CouponCardDrawerManagerProtocol>) drawerListener;
- (void) setDrawingData:(CouponDrawingData*) drowingData;

- (void) updateStateIfNeeded;

@end
