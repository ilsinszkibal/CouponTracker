//
//  CTTrackedViewController.m
//  CouponTracker
//
//  Created by Teveli László on 11/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTTrackedViewController.h"
#import "CTAnalytics.h"

@interface CTTrackedViewController ()

@end

@implementation CTTrackedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CTAnalytics new] logScreenEvent:NSStringFromClass([self class])];
}

@end
