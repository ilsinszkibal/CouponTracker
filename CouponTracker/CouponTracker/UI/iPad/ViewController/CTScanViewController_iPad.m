//
//  CTScanViewController_iPad.m
//  CouponTracker
//
//  Created by Teveli László on 28/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTScanViewController_iPad.h"

#import "CTContentDetailsViewController_Common.h"
#import "CTNewContentViewController_Common.h"

@interface CTScanViewController_iPad ()

@end

@implementation CTScanViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:) ];
    
    self.previewView.backgroundColor = [UIColor lightGrayColor];
    
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
    
    [self.previewView setFrame:CGRectMake(100, 100, 500, 500)];
    [self.startStopButton setFrame:CGRectMake(200, 650, 300, 30)];
    [self.statusLabel setFrame:CGRectMake(100, 750, 500, 44)];
    [self.instructionLabel setFrame:CGRectMake(100, 350, 500, 100)];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)showContentDetails:(Model_CardContent*)content {
    CTContentDetailsViewController_Common* viewController = [[CTContentDetailsViewController_Common alloc] init];
    viewController.content = content;
    viewController.card = self.card;
    [self navigateToViewController:viewController];
}

- (void)showNewContent {
    UIViewController* viewController = [[CTNewContentViewController_Common alloc] init];
    [self navigateToViewController:viewController];
}

@end
