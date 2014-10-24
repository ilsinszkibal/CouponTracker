//
//  CTCardsViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTCardsViewController_iPhone.h"
#import "CTNetworkingManager.h"

@interface CTCardsViewController_iPhone ()

@end

@implementation CTCardsViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:) ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[CTNetworkingManager sharedManager] createTemplateWithName:@"test" text:@"test2" image:[UIImage imageNamed:@"scan"] completion:^(Model_CardTemplate *template, NSError *error) {
        
    }];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
