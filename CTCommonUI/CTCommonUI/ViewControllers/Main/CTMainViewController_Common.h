//
//  CTMainViewController_Common.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

#import "CTMyTemplatesViewController_Common.h"
#import "CTPrintedCardViewController_Common.h"

@interface CTMainViewController_Common : CTViewController

- (void) showMyTemplates:(CTMyTemplatesViewController_Common*) myTemplates;
- (void) showPrintedCard:(CTPrintedCardViewController_Common*) printedCard;
- (IBAction)loginButtonPressed:(id)sender;

@end
