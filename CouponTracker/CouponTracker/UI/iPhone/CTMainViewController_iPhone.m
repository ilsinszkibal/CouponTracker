//
//  CTMainViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPhone.h"
#import "CTScanViewController_iPhone.h"
#import "CTMyTemplatesViewController_iPhone.h"
#import "CTCardsViewController_iPhone.h"
#import "CTInstructionsViewController_iPhone.h"
#import "CTUserManager.h"
#import "CTUser.h"

@interface CTMainViewController_iPhone ()

@property (nonatomic, strong) UILabel* loginLabel;

@property (nonatomic, strong) UIButton* loginButton;
@property (nonatomic, strong) UIButton* scanButton;
@property (nonatomic, strong) UIButton* cardsButton;
@property (nonatomic, strong) UIButton* templatesButton;

- (void)loginButtonPressed:(UIButton*)button;
- (void)scanButtonPressed:(UIButton*)button;
- (void)cardsButtonPressed:(UIButton*)button;
- (void)templatesButtonPressed:(UIButton*)button;

@end

@implementation CTMainViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginLabel = [[UILabel alloc] init];
    self.loginLabel.backgroundColor = [UIColor clearColor];
    self.loginLabel.textColor = [UIColor whiteColor];
    self.loginLabel.font = [UIFont boldSystemFontOfSize:16];
    self.loginLabel.numberOfLines = 0;
    [self.view addSubview:self.loginLabel];
    
    self.loginButton = [UIFactory defaultButtonWithTitle:@"Login" target:self action:@selector(loginButtonPressed:) ];
    [self.view addSubview:self.loginButton];
   
    self.cardsButton = [UIFactory defaultButtonWithTitle:@"My coupons" target:self action:@selector(cardsButtonPressed:) ];
    [self.view addSubview:self.cardsButton];
    
    self.templatesButton = [UIFactory defaultButtonWithTitle:@"Templates" target:self action:@selector(templatesButtonPressed:) ];
    [self.view addSubview:self.templatesButton];
    
    self.scanButton = [[UIButton alloc] init];
    [self.scanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.scanButton setBackgroundColor:[UIColor clearColor]];
    [self.scanButton setAlpha:0.65];
    [self.scanButton setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [self.view addSubview:self.scanButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self showInstructions];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.splashView startAnimation];
//    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.loginLabel setFrame:CGRectMake(20, 30, 280, 100)];
    
    [self.loginButton setFrame:CGRectMake(200, 20, 100, 40)];
    [self.cardsButton setFrame:CGRectMake(20, 500, 100, 40)];
    [self.templatesButton setFrame:CGRectMake(200, 500, 100, 40)];
    
    [self.scanButton setFrame:CGRectMake(110, 200, 100, 100)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[CTUserManager sharedManager] loginWithStoredCredentialsCompletion:^(CTUser *user, NSError *error) {
        [self refreshStatusLabel];
    }];
    
    [self refreshStatusLabel];    
}

- (void)refreshStatusLabel {
    CTUser* currentUser = [CTUserManager sharedManager].currentUser;
    if (currentUser) {
        if (currentUser.name || currentUser.username) {
            self.loginLabel.text = [NSString stringWithFormat:@"Welcome %@!", currentUser.name ?: currentUser.username];
        } else {
            self.loginLabel.text = @"Welcome!";
        }
    } else {
        self.loginLabel.text = @"You are not logged in.\nAfter you are part of the CouponTracker community, you can create custom beautiful coupon cards and spread them to the world!";
    }
}

- (void)loginButtonPressed:(UIButton*)button {
    [self showLogin];
}

- (void)scanButtonPressed:(UIButton*)button {
    UIViewController* login = [[CTScanViewController_iPhone alloc] init];
    [self navigateToViewController:login];
}

- (void)cardsButtonPressed:(UIButton*)button {
    if (self.isUserLoggedIn) {
        UIViewController* cards = [[CTCardsViewController_iPhone alloc] init];
        [self navigateToViewController:cards];
    } else {
        [self showLogin];
    }
}

- (void)templatesButtonPressed:(UIButton*)button {
    UIViewController* login = [[CTMyTemplatesViewController_iPhone alloc] init];
    [self navigateToViewController:login];
}

- (void)showInstructions {
    //CTInstructionsViewController_iPhone* instructions = [[CTInstructionsViewController_iPhone alloc] init];
    //[self showViewController:instructions sender:self];
}

@end
