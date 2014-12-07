//
//  CTMainViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_Common.h"
#import "CTUserManager.h"

@interface CTMainViewController_Common ()
{
    CTMyTemplatesViewController_Common* _myTemplatesVC;
    CTPrintedCardViewController_Common* _printedCardVC;
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

- (void) showPrintedCard:(CTPrintedCardViewController_Common*) printedCard
{
    _printedCardVC = printedCard;
    [self navigateToViewController:_printedCardVC];
}

#pragma mark Handling navigation

@end
