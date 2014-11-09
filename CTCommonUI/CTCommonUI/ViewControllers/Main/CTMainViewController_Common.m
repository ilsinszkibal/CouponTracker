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

- (IBAction)loginButtonPressed:(id)sender {
    [self showLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

#pragma mark Navigating

- (void) showMyTemplates:(CTMyTemplatesViewController_Common*) myTemplates
{
    
    if ( [self isUserLoggedIn] == NO )
    {
        [self showLogin];
        return;
    }
    
    _myTemplatesVC = myTemplates;
    [self navigateToViewController:_myTemplatesVC];
}

#pragma mark Handling navigation

@end
