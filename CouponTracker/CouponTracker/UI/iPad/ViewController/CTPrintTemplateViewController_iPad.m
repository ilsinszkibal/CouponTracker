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
    
    UIButton* _backButton;
    
    UIView* _passingView;
    
}

@end

@implementation CTPrintTemplateViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector( backButtonAction: ) ];
    [self.view addSubview:_backButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - LayoutSubviews

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_backButton setFrame:CGRectMake(0, 25, 120, 44)];
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
    return CGRectMake(self.view.frame.size.width - 250, 50, 200, 200);
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    _passingView = view;
    [self.view addSubview:_passingView];
}

@end
