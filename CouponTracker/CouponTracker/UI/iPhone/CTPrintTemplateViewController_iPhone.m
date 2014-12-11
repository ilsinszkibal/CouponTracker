//
//  CTPrintTemplateViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintTemplateViewController_iPhone.h"
#import "CTAnalytics.h"

@interface CTPrintTemplateViewController_iPhone ()

@property (nonatomic, strong) UIView* passingView;

@end

@implementation CTPrintTemplateViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CTAnalytics new] logScreenEvent:NSStringFromClass([self class])];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self print];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CTPassingViewNavigating protocol

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    return self.passingView;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    return CGRectMake(self.view.width - 200, 85, 150, 100);
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    self.passingView = view;
    [self.view addSubview:self.passingView];
}

@end
