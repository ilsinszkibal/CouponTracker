//
//  CTPrintTemplateViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintTemplateViewController_iPhone.h"

@interface CTPrintTemplateViewController_iPhone ()

@end

@implementation CTPrintTemplateViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self print];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
