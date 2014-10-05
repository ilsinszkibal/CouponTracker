//
//  CTMainViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_Common.h"

@interface CTMainViewController_Common ()
{
    CTMyTemplatesViewController_Common* _myTemplatesVC;
}

@end

@implementation CTMainViewController_Common

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

#pragma mark Navigating

- (void) showMyTemplates:(CTMyTemplatesViewController_Common*) myTemplates
{
    _myTemplatesVC = myTemplates;
    [self presentViewController:_myTemplatesVC animated:YES completion:nil];
}

#pragma mark Handling navigation

@end
