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

@implementation CTContentDetailsViewController_Common

- (void)viewDidLoad
{
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:)];
    
    [self setUpTopRightButtonWithTitle:@"Hand off" withSel:@selector(handoffButtonPressed:)];
    
    self.contentView = [[CTCardContentView alloc] init];
    self.contentView.content = self.content;
    [self.view addSubview:self.contentView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BOOL isOpen = self.content.senderUser != nil && self.content.receiverUser == nil;
    BOOL isClosed = self.content.senderUser != nil && self.content.receiverUser != nil;
    BOOL isMine = YES;//FIXME: determine receiver
    if (isOpen) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"This card is unassigned" message:@"Do you want to take ownership?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[CTNetworkingManager sharedManager] ownCard:self.content completion:^(Model_CardContent *card, NSError *error) {
                
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (isClosed && isMine == NO) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"This card is closed" message:@"Do you want to reuse it with a new content?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self navigateToNew];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self backButtonPressed:nil];
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

- (void)navigateToNew {

}

@end
