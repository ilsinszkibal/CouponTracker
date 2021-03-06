//
//  CTScanViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTScanViewController_iPhone.h"

#import "CTContentDetailsViewController_iPhone.h"
#import "CTNewContentViewController_iPhone.h"
#import "CTAnalytics.h"

@interface CTScanViewController_iPhone ()

@property (nonatomic, strong) UIButton* backButton;

- (void)backButtonPressed:(UIButton*)backButton;

@end

@implementation CTScanViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CTAnalytics new] logScreenEvent:NSStringFromClass([self class])];
    
    self.backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonPressed:)];
    [self.view addSubview:self.backButton];
    
    self.previewView.backgroundColor = [UIColor lightGrayColor];
    self.previewView.layer.cornerRadius = 5;
    
    self.startStopButton = [UIFactory defaultButtonWithTitle:@"Start" target:self action:@selector(startStopButtonPressed:)];
    [self.view addSubview:self.startStopButton];
    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.numberOfLines = 1;
    self.statusLabel.backgroundColor = [UIColor clearColor];
    self.statusLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.statusLabel];
    
    self.instructionLabel = [[UILabel alloc] init];
    self.instructionLabel.numberOfLines = 1;
    self.instructionLabel.backgroundColor = [UIColor clearColor];
    self.instructionLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.instructionLabel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.backButton setFrame:CGRectMake(20, 30, 50, 30)];
    [self.previewView setFrame:CGRectMake(60, 70, 200, 200)];
    [self.startStopButton setFrame:CGRectMake(60, 290, 200, 30)];
    [self.statusLabel setFrame:CGRectMake(60, 330, 200, 30)];
    [self.instructionLabel setFrame:CGRectMake(60, 150, 200, 40)];
    [self.spinner setFrame:CGRectMake(140, 400, 50, 50)];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)showContentDetails:(Model_CardContent*)content {
    CTContentDetailsViewController_iPhone* viewController = [[CTContentDetailsViewController_iPhone alloc] init];
    viewController.content = content;
    viewController.card = self.card;
    [self navigateToViewController:viewController];
}

- (void)showNewContent {
    if (self.isUserLoggedIn) {
        CTNewContentViewController_iPhone* viewController = [[CTNewContentViewController_iPhone alloc] init];
        viewController.card = self.card;
        [self navigateToViewController:viewController];
    } else {
        [self showLogin];
        [[[UIAlertView alloc] initWithTitle:@"Empty card" message:@"You need to be logged in to write somw content into the card. Log in antr try again later." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
    }
}

@end
