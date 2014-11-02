//
//  CTNewContentViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewContentViewController_iPhone.h"
#import "CTComposeViewController.h"
#import "CTNetworkingManager.h"

@interface CTNewContentViewController_iPhone ()

@property (nonatomic, strong) CTComposeViewController* composeViewController;
@property (nonatomic, strong) UIActivityIndicatorView* spinner;

@end

@implementation CTNewContentViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
    
    self.composeViewController = [[CTComposeViewController alloc] init];
    self.composeViewController.title = @"New coupon content";
    self.composeViewController.attachmentImage = [UIImage imageNamed:@"scan2"];
    self.composeViewController.text = @"Hi there!";
    __weak CTNewContentViewController_iPhone* weakSelf = self;
    self.composeViewController.completionHandler = ^(REComposeViewController *composeViewController, REComposeResult result) {
        if (result == REComposeResultCancelled) {
            [weakSelf backButtonPressed:nil];
            [composeViewController dismissViewControllerAnimated:YES completion:nil];
        } else if (result == REComposeResultPosted) {
            [weakSelf.spinner startAnimating];
            
            if (weakSelf.isHandoff) {
                [[CTNetworkingManager sharedManager] handoffCardWithNewContentWithCode:composeViewController.text completion:^(Model_CardContent *card, NSError *error) {
                    [weakSelf.spinner startAnimating];
                    [composeViewController dismissViewControllerAnimated:YES completion:nil];
                }];
            } else {
                [[CTNetworkingManager sharedManager] createContentWithCode:composeViewController.text completion:^(Model_CardContent *card, NSError *error) {
                    [weakSelf.spinner startAnimating];
                    [composeViewController dismissViewControllerAnimated:YES completion:nil];
                }];
            }
        }
    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.spinner setCenter:self.view.center];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.composeViewController presentFromViewController:self];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
