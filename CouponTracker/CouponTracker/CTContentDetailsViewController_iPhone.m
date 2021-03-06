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
#import "CTAnalytics.h"

@implementation CTContentDetailsViewController_iPhone

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CTAnalytics new] logScreenEvent:NSStringFromClass([self class])];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.contentView setFrame:CGRectMake(60, 100, 200, 300)];
}

- (void)navigateToHandoff {
    CTNewContentViewController_iPhone* controller = [[CTNewContentViewController_iPhone alloc] init];
    controller.isHandoff = YES;
    controller.contentViewController = self;
    [self navigateToViewController:controller];
}

@end
