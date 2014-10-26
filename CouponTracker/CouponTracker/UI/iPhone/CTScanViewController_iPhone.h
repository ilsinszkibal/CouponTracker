//
//  CTScanViewController_iPhone.h
//  CouponTracker
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTScanViewController_Common.h"

@class Model_CardContent;

@interface CTScanViewController_iPhone : CTScanViewController_Common

- (void)showContentDetails:(Model_CardContent*)content;
- (void)showNewContent;

@end
