//
//  CTScanViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTScanViewController_iPhone.h"

#import "UIFactory.h"

@interface CTScanViewController_iPhone ()

@property (nonatomic, strong) UIButton* backButton;

- (void)backButtonPressed:(UIButton*)backButton;

@end

@implementation CTScanViewController_iPhone

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //test
    [self codeDidRead:@"http://coupontracker.org/code/1f1g2h3i4j5" ofType:@"test"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonPressed:)];
    [self.view addSubview:self.backButton];
    
    self.previewView = [[UIView alloc] init];
    self.previewView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.previewView];
    
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
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end