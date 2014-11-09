//
//  CTPrintTemplateViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintTemplateViewController_iPad.h"

@interface CTPrintTemplateViewController_iPad () {
    UIView* _passingView;
    
}

@end

@implementation CTPrintTemplateViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector( backButtonAction: ) ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - LayoutSubviews

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
