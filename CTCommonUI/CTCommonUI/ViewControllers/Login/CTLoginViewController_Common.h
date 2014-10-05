//
//  CTLoginViewController.h
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

@interface CTLoginViewController_Common : CTViewController

@property (nonatomic, strong) UIView* contentView;

@property (nonatomic, strong) UITextField* usernameField;
@property (nonatomic, strong) UITextField* emailField;
@property (nonatomic, strong) UITextField* passwordField;
@property (nonatomic, strong) UITextField* passwordConfirmField;

@property (nonatomic, strong) UILabel* statusLabel;
@property (nonatomic, strong) UIButton* loginButton;
@property (nonatomic, strong) UIButton* notNowButton;
@property (nonatomic, strong) UIButton* registerButton;

- (void) loginAction:(UIButton*) button;
- (void) notNowAction:(UIButton*) sender;
- (void) registerAction:(UIButton*) sender;

@end
