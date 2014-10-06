//
//  CTMainViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPad.h"

#import "UIFactory.h"

#import "CTMyTemplatesViewController_iPad.h"

@interface CTMainViewController_iPad () {
    
    UIButton* _showMyTemplatesButton;
    UIButton* _loginButton;
    
}

@end

@implementation CTMainViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _showMyTemplatesButton = [UIFactory defaultButtonWithTitle:@"My templates" target:self action:@selector(showMyTemplatesAction:) ];
    [self.view addSubview:_showMyTemplatesButton];
    
    _loginButton = [UIFactory defaultButtonWithTitle:@"Login" target:self action:@selector(loginButtonAction:) ];
    [self.view addSubview:_loginButton];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_showMyTemplatesButton setFrame:CGRectMake(200, 400, 150, 44) ];
    [_loginButton setFrame:CGRectMake(200, 450, 150, 44) ];
    
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

@end
