//
//  CTContentDetailsViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTContentDetailsViewController_iPhone.h"
#import "CTNewContentViewController_iPhone.h"
#import "CTCardContentView.h"

@implementation CTContentDetailsViewController_iPhone

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.contentView setFrame:CGRectMake(60, 100, 200, 300)];
}

- (void)navigateToHandoff {
    CTNewContentViewController_iPhone* controller = [[CTNewContentViewController_iPhone alloc] init];
    controller.isHandoff = YES;
    [self navigateToViewController:controller];
}

- (void)navigateToNew {
    CTNewContentViewController_iPhone* controller = [[CTNewContentViewController_iPhone alloc] init];
    controller.isHandoff = NO;
    [self navigateToViewController:controller];
}

@end
