//
//  CouponCardDrawerManagerListener.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponCardDrawerManagerProtocol.h"


@interface CouponCardDrawerManagerListener : NSObject<CouponCardDrawerManagerProtocol>

- (id) initWithDrawerManager:(id<CouponCardDrawerManagerProtocol>) drawerManager;

@end
