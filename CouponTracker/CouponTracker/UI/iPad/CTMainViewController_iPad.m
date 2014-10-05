//
//  CTMainViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPad.h"

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
    
    _showMyTemplatesButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_showMyTemplatesButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_showMyTemplatesButton setTitle:@"My templates2" forState:UIControlStateNormal];
    [_showMyTemplatesButton addTarget:self action:@selector(showMyTemplatesAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_showMyTemplatesButton];
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    [self.view setBackgroundColor:[UIColor orangeColor] ];
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
