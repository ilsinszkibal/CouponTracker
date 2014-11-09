//
//  CTMainViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPad.h"

#import "CTMyTemplatesViewController_iPad.h"
#import "CTScanViewController_iPad.h"

@interface CTMainViewController_iPad () {
    
    UIButton* _loginButton;
    UIButton* _scanButton;
    
}

@end

@implementation CTMainViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTopRightButtonWithTitle:@"My templates" withSel:@selector(showMyTemplatesAction:) ];
    
    _loginButton = [UIFactory defaultButtonWithTitle:@"Login" target:self action:@selector(loginButtonAction:) ];
    [self.view addSubview:_loginButton];
    
    _scanButton = [UIFactory defaultButtonWithTitle:@"Scan" target:self action:@selector(scanButtonPressed:)];
    [self.view addSubview:_scanButton];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_loginButton setFrame:CGRectMake(200, 450, 150, 44) ];
    [_scanButton setFrame:CGRectMake(200, 600, 150, 44)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void) showMyTemplatesAction:(UIButton*) button
{
    CTMyTemplatesViewController_iPad* myTemplates = [[CTMyTemplatesViewController_iPad alloc] init];
    [self showMyTemplates:myTemplates];
}

- (void) loginButtonAction:(UIButton*) button
{
    [self showLogin];
}

- (void) scanButtonPressed:(UIButton*) button
{
    CTScanViewController_iPad* scan = [[CTScanViewController_iPad alloc] init];
    [self navigateToViewController:scan];
}

@end
