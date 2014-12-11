//
//  CTPrintTemplateViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintTemplateViewController_iPad.h"

#import "UIFactory.h"

@interface CTPrintTemplateViewController_iPad () {
    UIView* _passingView;
    
    UIButton* _printButton;
    
}

@end

@implementation CTPrintTemplateViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector( backButtonAction: ) ];
    
    _printButton = [UIFactory defaultButtonWithTitle:@"Print" target:self action:@selector(print:)];
    [self.view addSubview:_printButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self print];
}

#pragma mark - LayoutSubviews

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_passingView setFrame:[self passingViewRectForKey:nil] ];
    
    [_printButton setFrame:CGRectIntegral( CGRectMake(self.view.width / 2.0 - 150 / 2.0, self.view.height / 2.0 - 44 / 2.0, 150, 44) ) ];
    
}

#pragma mark - Action

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - CTPassingViewNavigating protocol

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    return _passingView;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    return CGRectMake(self.view.width - 250, 50, 200, 200);
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    _passingView = view;
    [self.view addSubview:_passingView];
}

@end
