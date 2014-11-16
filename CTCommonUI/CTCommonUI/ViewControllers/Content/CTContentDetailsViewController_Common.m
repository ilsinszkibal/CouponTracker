//
//  CTContentDetailsViewController_Common.m
//  CTCommonUI
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTContentDetailsViewController_Common.h"
#import "CTCardContentView.h"
#import "CTNetworkingManager.h"
#import "Model.h"
#import <MessageUI/MessageUI.h>

@interface CTContentDetailsViewController_Common () <MFMailComposeViewControllerDelegate>

@end

@implementation CTContentDetailsViewController_Common

- (void)viewDidLoad
{
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
    
    [self setUpTopRightButtonWithTitle:@"Hand off" withSel:@selector(handoffButtonPressed:)];
    
    self.contentView = [[CTCardContentView alloc] init];
    self.contentView.content = self.content;
    [self.view addSubview:self.contentView];
    
    self.handoffEnabled = YES;
}

- (void)setHandoffEnabled:(BOOL)handoffEnabled
{
    _handoffEnabled = handoffEnabled;
    self.handoffButton.enabled = handoffEnabled;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.content.senderUser != nil && self.content.receiverUser == nil) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"This card is unassigned" message:@"Do you want to take ownership?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (self.isUserLoggedIn) {
                [[CTNetworkingManager sharedManager] ownCard:self.content completion:^(Model_CardContent *card, NSError *error) {
                    if (!error) {
                        [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Now you are the owner of this card" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                    }
                }];
            } else {
                [self showLogin];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (self.content.senderUser != nil && self.content.receiverUser != nil) {
        //do nothing because closed, and can be hand off
    } else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid card" message:[NSString stringWithFormat:@"Please report this card, because it is in an invalid state. (Identification: %@)", self.card.code] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([MFMailComposeViewController canSendMail]) {
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                mail.mailComposeDelegate = self;
                [mail setSubject:@"Reporting card"];
                [mail setMessageBody:[NSString stringWithFormat:@"Some error happened with the reading of card %@!", self.card.code] isHTML:NO];
                [mail setToRecipients:@[@"report@coupontracker.org"]];
                [self presentViewController:mail animated:YES completion:NULL];
            }
            else
            {
                NSLog(@"This device cannot send email");
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Not now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handoffButtonPressed:(UIButton *)button {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Hand off" message:@"Do you want to reuse this card with a new content?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self navigateToHandoff];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)navigateToHandoff {
    
}

#pragma mark - Mail

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
