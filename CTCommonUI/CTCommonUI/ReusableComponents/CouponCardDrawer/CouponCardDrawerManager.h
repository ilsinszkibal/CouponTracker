//
//  CouponCardDrawerManager.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CouponCardDrawerManagerProtocol.h"

#import "CardDrawingPresentView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingLayerView.h"

@interface CouponCardDrawerManager : NSObject<CouponCardDrawerManagerProtocol>

- (id) initWithPresentView:(CardDrawingPresentView*) presentView withLayerView:(CardDrawingLayerView*) layerView withOperationView:(CardDrawingOperationView*) operationView;

@end
