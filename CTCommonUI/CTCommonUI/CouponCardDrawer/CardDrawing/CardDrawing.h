//
//  CardDrawing.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CouponDrawingData;
@class CouponDrawingBaseLayer;

@interface CardDrawing : NSObject

- (UIImage*) drawCard:(CouponDrawingData*) couponDrawingData withSize:(CGSize) size;

- (void) drawSingleLayerInSession:(CouponDrawingBaseLayer*) layer withSize:(CGSize) size;

@end
