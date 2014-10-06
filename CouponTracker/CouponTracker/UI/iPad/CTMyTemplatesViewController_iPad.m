//
//  CTMyTemplatesViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPad.h"

#import "CTNewTemplateViewController_iPad.h"

@interface CTMyTemplatesViewController_iPad () {
    
    UIButton* _backButton;
    UIButton* _newTemplateButton;
    
}

@end

@implementation CTMyTemplatesViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"Back" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
 
    _newTemplateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_newTemplateButton setTitle:@"New template" forState:UIControlStateNormal];
    [_newTemplateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_newTemplateButton addTarget:self action:@selector(newTemplateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newTemplateButton];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getMyCards:^(NSArray *cards, NSError *error) {
        NSLog(@"Got cards %@", cards);
    }];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_backButton setFrame:CGRectMake(0, 0, 120, 44)];
    [_newTemplateButton setFrame:CGRectMake(0, 50, 120, 44)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void) newTemplateButtonAction:(UIButton*) button
{
    CTNewTemplateViewController_iPad* newTemplate = [[CTNewTemplateViewController_iPad alloc] init];
    [self showNewTemplate:newTemplate];
}

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
