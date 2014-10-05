//
//  CTLoginViewController.h
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

@interface CTLoginViewController_Common : CTViewController

@property (nonatomic, weak) IBOutlet UIView* contentView;

@property (nonatomic, weak) IBOutlet UITextField* usernameField;
@property (nonatomic, weak) IBOutlet UITextField* passwordField;

@property (nonatomic, weak) IBOutlet UILabel* statusLabel;
@property (nonatomic, weak) IBOutlet UIButton* loginButton;
@property (nonatomic, weak) IBOutlet UIButton* notNowButton;
@property (nonatomic, weak) IBOutlet UIButton* registerButton;

- (IBAction) loginAction:(UIButton*) button;
- (IBAction) notNowAction:(UIButton*) sender;
- (IBAction) registerAction:(UIButton*) sender;

@end
