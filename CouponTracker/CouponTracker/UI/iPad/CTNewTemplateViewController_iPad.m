//
//  CTNewTemplateViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_iPad.h"

@interface CTNewTemplateViewController_iPad () {
    
    UIButton* _backButton;
    
}

@end

@implementation CTNewTemplateViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor greenColor] ];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_backButton setFrame:CGRectMake(0, 0, 120, 44)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
