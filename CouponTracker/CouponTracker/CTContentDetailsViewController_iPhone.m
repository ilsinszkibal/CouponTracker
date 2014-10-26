//
//  CTContentDetailsViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTContentDetailsViewController_iPhone.h"

@implementation CTContentDetailsViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end