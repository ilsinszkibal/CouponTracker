//
//  CT_ScanViewController_Common.m
//  CTCommonUI
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTScanViewController_Common.h"
#import "CTNetworkingManager.h"
#import "Model.h"
#import "CCValidationManager.h"

@interface CTScanViewController_Common ()

@property (nonatomic, strong) Model_PrintedCard* card;

@end

@implementation CTScanViewController_Common

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.instructionLabel.text = @"Tap START to read a card";
    self.previewView.layer.borderWidth = 2.0;
    [[CTQRCodeManager sharedManager] setPreviewView:self.previewView];
    [[CTQRCodeManager sharedManager] setDelegate:self];
    
    self.previewView = [[UIView alloc] init];
    [CTQRCodeManager sharedManager].previewView = self.previewView;
    [self.view addSubview:self.previewView];
    
    [self stop];
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL suCTess = [[CTQRCodeManager sharedManager] prepareForReading];
    if (!suCTess) {
        [self disable];
    }
}

- (void)startStopButtonPressed:(UIButton*)button {
    if ([[CTQRCodeManager sharedManager] isReading]) {
        [[CTQRCodeManager sharedManager] stopReading];
        [self stop];
    } else {
        BOOL success = [[CTQRCodeManager sharedManager] startReading];
        if (success) {
            [self start];
        } else {
            [self disable];
        }
    }
}

- (void)stop {
    self.instructionLabel.hidden = NO;
    if ([self.statusLabel.text isEqualToString:@"Reading..."]) {
        self.statusLabel.text = @"";
    }
    [self.startStopButton setTitle:@"START" forState:UIControlStateNormal];
}

- (void)start {
    self.instructionLabel.hidden = YES;
    self.statusLabel.text = @"Reading...";
    [self.startStopButton setTitle:@"STOP" forState:UIControlStateNormal];
}

- (void)disable {
    self.statusLabel.text = @"Could not prepare for reading.";
    self.instructionLabel.hidden = YES;
    self.startStopButton.enabled = NO;
}

#pragma mark - CTCodeReaderDelegate

- (void)codeDidRead:(NSString *)code ofType:(NSString *)type {
    BOOL isValidUrl = [[CCValidator validatorWithConditions:@[[CCUrlCondition condition]]] validateValue:code errors:nil];
    if (isValidUrl) {
        self.statusLabel.text = [NSString stringWithFormat:@"%@ found: %@", type, code];
        [[CTNetworkingManager sharedManager] readCardWithCode:code.lastPathComponent completion:^(Model_CardRead *read, NSError *error) {
            if (read.card) {
                self.card = read.card;
//                [self performSegueWithIdentifier:@"showCardDetails" sender:self];
            } else {
                [self showInvalidAlert];
            }
        }];
    } else {
        self.statusLabel.text = @"Not a valid coupon code";
        [self showInvalidAlert];
    }
}

- (void)showInvalidAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Card read" message:@"This is not a valid CouponTracker card" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        BOOL success = [[CTQRCodeManager sharedManager] startReading];
        if (success) {
            [self start];
        } else {
            [self disable];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)readingDidStart {
    [self start];
}

- (void)readingDidStop {
    [self stop];
}

@end