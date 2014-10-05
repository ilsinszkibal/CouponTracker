//
//  CTMainViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPhone.h"

@interface CTMainViewController_iPhone ()

@property (nonatomic, strong) UIButton* loginButton;

- (void)loginButtonPressed:(UIButton*)button;

@end

@implementation CTMainViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
