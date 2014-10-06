//
//  CTMyTemplatesViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPad.h"

#import "UIFactory.h"

#import "CTNewTemplateViewController_iPad.h"

@interface CTMyTemplatesViewController_iPad () {
    
    UIButton* _backButton;
    UIButton* _newTemplateButton;
    
}

@end

@implementation CTMyTemplatesViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonAction:) ];
    [self.view addSubview:_backButton];
 
    _newTemplateButton = [UIFactory defaultButtonWithTitle:@"New template" target:self action:@selector(newTemplateButtonAction:) ];
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
