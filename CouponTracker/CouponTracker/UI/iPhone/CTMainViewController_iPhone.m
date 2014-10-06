//
//  CTMainViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPhone.h"

#import "UIFactory.h"

@interface CTMainViewController_iPhone ()

@property (nonatomic, strong) UIButton* loginButton;

- (void)loginButtonPressed:(UIButton*)button;

@end

@implementation CTMainViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton = [UIFactory defaultButtonWithTitle:@"Login" target:self action:@selector(loginButtonPressed:) ];
    [self.view addSubview:self.loginButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.loginButton setFrame:CGRectMake(20, 20, 100, 40)];
}

- (void)loginButtonPressed:(UIButton*)button {
    [self showLogin];
}

@end
