//
//  CTContentDetailsViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 11/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTContentDetailsViewController_iPad.h"

#import "CTCardContentView.h"
#import "CTNewContentViewController_iPhone.h"

@implementation CTContentDetailsViewController_iPad

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.contentView setFrame:CGRectMake(self.view.width / 2.0 - 100, self.view.height / 2.0 - 150, 200, 300)];
}

- (void)navigateToHandoff {
    CTNewContentViewController_iPhone* controller = [[CTNewContentViewController_iPhone alloc] init];
    controller.isHandoff = YES;
    controller.contentViewController = self;
    [self navigateToViewController:controller];
}

@end
