//
//  CTLoginViewController.m
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTLoginViewController_Common.h"
#import "CTUserManager.h"
#import "CTUser.h"
#import "CCValidationManager.h"
#import "CTTwoStateButton.h"
#import "CTValidTextField.h"

@interface CTLoginViewController_Common () <CTTextFieldDelegate>

@property (nonatomic, strong) CTValidTextField* usernameField;
@property (nonatomic, strong) CTValidTextField* fullnameField;
@property (nonatomic, strong) CTValidTextField* emailField;
@property (nonatomic, strong) CTValidTextField* passwordField;
@property (nonatomic, strong) CTValidTextField* passwordConfirmationField;

@property (nonatomic, strong) UILabel* statusLabel;
@property (nonatomic, strong) UIButton* actionButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) CTTwoStateButton* switchButton;

@property (nonatomic, assign) CTLoginViewState currentState;

- (void) actionButtonPressed:(UIButton*) button;
- (void) cancelButtonPressed:(UIButton*) sender;
- (void) switchButtonPressed:(CTTwoStateButton*) sender;

@end

@implementation CTLoginViewController_Common

#pragma mark - ViewController override

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effect = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effect.frame = self.view.bounds;
    [self.view addSubview:effect];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.usernameField = [[CTValidTextField alloc] init];
    self.usernameField.delegate = self;
    [self.usernameField setPlaceholder:@"username"];
    self.usernameField.validationBlock = ^BOOL(NSString* text) {
        return [[CTUserManager sharedManager].usernameValidator validateValue:text errors:nil];
    };
    self.usernameField.valid = NO;
    [self.view addSubview:self.usernameField];
    
    self.fullnameField = [[CTValidTextField alloc] init];
    self.fullnameField.delegate = self;
    [self.fullnameField setPlaceholder:@"full name"];
    self.fullnameField.validationBlock = ^BOOL(NSString* text) {
        CCValidationCondition* length = [CCLengthCondition conditionWithMinLength:4];
        CCIncludingCondition* space = [CCIncludingCondition condition];
        [space includePart:CCIncludingPartWhitespace minimum:1];
        return [[CCValidator validatorWithConditions:@[length, space]] validateValue:text errors:nil];
    };
    self.fullnameField.valid = NO;
    [self.view addSubview:self.fullnameField];
    
    self.emailField = [[CTValidTextField alloc] init];
    self.emailField.delegate = self;
    [self.emailField setPlaceholder:@"email address"];
    self.emailField.validationBlock = ^BOOL(NSString* text) {
        return [[CTUserManager sharedManager].emailValidator validateValue:text errors:nil];
    };
    self.emailField.valid = NO;
    [self.view addSubview:self.emailField];
    
    self.passwordField = [[CTValidTextField alloc] init];
    self.passwordField.delegate = self;
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setPlaceholder:@"password"];
    self.passwordField.validationBlock = ^BOOL(NSString* text) {
        return [[CTUserManager sharedManager].passwordValidator validateValue:text errors:nil];
    };
    self.passwordField.valid = NO;
    [self.view addSubview:self.passwordField];
    
    self.passwordConfirmationField = [[CTValidTextField alloc] init];
    self.passwordConfirmationField.delegate = self;
    [self.passwordConfirmationField setSecureTextEntry:YES];
    [self.passwordConfirmationField setPlaceholder:@"confirmation"];
    __weak CTLoginViewController_Common* weakSelf = self;
    self.passwordConfirmationField.validationBlock = ^BOOL(NSString* text) {
        CCMatchingCondition* match = [CCMatchingCondition conditionMatchesValue:weakSelf.passwordField.text];
        CCRequiredCondition* notEmpty = [CCRequiredCondition condition];
        return [[CCValidator validatorWithConditions:@[match, notEmpty]] validateValue:text errors:nil];
    };
    self.passwordConfirmationField.valid = NO;
    [self.view addSubview:self.passwordConfirmationField];
    
    self.statusLabel = [[UILabel alloc] init];
    [self.view addSubview:self.statusLabel];
    
    self.actionButton = [[UIButton alloc] init];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.actionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [self.view addSubview:self.actionButton];
    
    self.cancelButton = [[UIButton alloc] init];
    [self.cancelButton setTitle:@"Not now" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.switchButton = [[CTTwoStateButton alloc] init];
    [self.switchButton setTitle:@"Login" forButtonState:CTButtonStateActive];
    [self.switchButton setTitle:@"Register" forButtonState:CTButtonStateInactive];
    [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchButton setCurrentState:CTButtonStateInactive];
    [self.view addSubview:self.switchButton];
   
    self.currentState = CTLoginViewStateLogin;
    [self switchToState:self.currentState];
    
//    [[CTUserManager sharedManager].userSignal subscribeNext:^(CTUser* user) {
//        if (self.currentState == CTLoginViewStateLogin) {
//            if (user) {
//                self.statusLabel.text = @"Authenticated";
//                [self.actionButton setTitle:@"Logout" forState:UIControlStateNormal];
//            } else {
//                self.statusLabel.text = @"Unauthenticated";
//                [self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
//            }
//        } else if (self.currentState == CTLoginViewStateRegister) {
//            if (user) {
//                self.statusLabel.text = @"Success";
//                [self.actionButton setTitle:@"Logout" forState:UIControlStateNormal];
//            } else {
//                self.statusLabel.text = @"";
//                [self.actionButton setTitle:@"Register" forState:UIControlStateNormal];
//            }
//        }
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CTUserManager sharedManager] loginWithStoredCredentialsCompletion:nil];
}

- (void)switchToState:(CTLoginViewState)state {
    if (state == CTLoginViewStateLogin) {
        [self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.switchButton setCurrentState:CTButtonStateInactive];
        [self setupLoginViews];
    } else if (state == CTLoginViewStateRegister) {
        [self.actionButton setTitle:@"Register" forState:UIControlStateNormal];
        [self.switchButton setCurrentState:CTButtonStateActive];
        [self setupRegisterViews];
    } else if (state == CTLoginViewStateForgot) {
        //TODO:
    }
}

#pragma mark - Actions

- (void) actionButtonPressed:(UIButton*) button {
    [self.usernameField resignFirstResponder];
    [self.fullnameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.passwordConfirmationField resignFirstResponder];

    if (self.currentState == CTLoginViewStateLogin) {
        CTUser* user = [[CTUser alloc] init];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        [[CTUserManager sharedManager] loginUser:user completion:^(CTUser *user, NSError *error) {
            if (!error) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else if (self.currentState == CTLoginViewStateRegister) {
        CTUser* user = [[CTUser alloc] init];
        user.username = self.usernameField.text;
        user.name = self.fullnameField.text;
        user.email = self.emailField.text;
        user.password = self.passwordField.text;
        [[CTUserManager sharedManager] signupUser:user completion:^(CTUser *user, NSError *error) {
            if (!error) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}

- (void) cancelButtonPressed:(UIButton*) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-  (void) switchButtonPressed:(CTTwoStateButton*) sender {
    if (self.currentState == CTLoginViewStateLogin) {
        self.currentState = CTLoginViewStateRegister;
    } else if (self.currentState == CTLoginViewStateRegister) {
        self.currentState = CTLoginViewStateLogin;
    }
    [self switchToState:self.currentState];
}

#pragma mark - Public methods for showing login and register

- (void) showLogin {
    [self switchToState:CTLoginViewStateLogin];
}

- (void) showRegister {
    [self switchToState:CTLoginViewStateRegister];
}

#pragma mark - Validation

- (void)textFieldDidBecameValid:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        textField.backgroundColor = [UIColor colorWithRed:0.78 green:1 blue:0.63 alpha:1];
    }];
}

- (void)textFieldDidBecameInvalid:(UITextField *)textField {
    [UIView animateWithDuration:0.2 animations:^{
        textField.backgroundColor = [UIColor colorWithRed:1 green:0.19 blue:0.24 alpha:1];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (self.currentState == CTLoginViewStateLogin) {
        if ([textField isEqual:self.usernameField]) {
            [self.passwordField becomeFirstResponder];
        }
    } else if (self.currentState == CTLoginViewStateRegister) {
        if ([textField isEqual:self.fullnameField]) {
            [self.usernameField becomeFirstResponder];
        } else if ([textField isEqual:self.usernameField]) {
            [self.emailField becomeFirstResponder];
        } else if ([textField isEqual:self.emailField]) {
            [self.passwordField becomeFirstResponder];
        } else if ([textField isEqual:self.passwordField]) {
            [self.passwordConfirmationField becomeFirstResponder];
        }
    }
    return YES;
}

#pragma mark - Setup

- (void)setupLoginViews {
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        self.usernameField.frame = CGRectMake(60, 60, 200, 35);
        self.passwordField.frame = CGRectMake(60, CGRectGetMaxY(self.usernameField.frame) + 10, 200, 35);
        
        self.fullnameField.frame = self.usernameField.frame;
        self.emailField.frame = self.usernameField.frame;
        self.passwordConfirmationField.frame = self.passwordField.frame;
        
        self.switchButton.frame = CGRectMake(30, CGRectGetMaxY(self.passwordField.frame) + 10, 80, 40);
        self.cancelButton.frame = CGRectMake(CGRectGetMaxX(self.switchButton.frame) + 10, CGRectGetMinY(self.switchButton.frame), 100, 40);
        self.actionButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, CGRectGetMinY(self.cancelButton.frame), 80, 40);

        self.emailField.alpha = 0;
        self.passwordConfirmationField.alpha = 0;
        self.fullnameField.alpha = 0;
    } completion:nil];
}

- (void)setupRegisterViews {
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        self.usernameField.alpha = 0.75;
        self.passwordField.alpha = 0.75;
    } completion:nil];
    
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        self.fullnameField.frame = CGRectMake(60, 20, 200, 35);
        self.usernameField.frame = CGRectMake(60, CGRectGetMaxY(self.fullnameField.frame) + 10, 200, 35);
        self.emailField.frame = CGRectMake(60, CGRectGetMaxY(self.usernameField.frame) + 10, 200, 35);
        self.passwordField.frame = CGRectMake(60, CGRectGetMaxY(self.emailField.frame) + 10, 200, 35);
        self.passwordConfirmationField.frame = CGRectMake(60, CGRectGetMaxY(self.passwordField.frame) + 10, 200, 35);
        
        self.switchButton.frame = CGRectMake(30, CGRectGetMaxY(self.passwordConfirmationField.frame) + 10, 80, 40);
        self.cancelButton.frame = CGRectMake(CGRectGetMaxX(self.switchButton.frame) + 10, CGRectGetMinY(self.switchButton.frame), 100, 40);
        self.actionButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, CGRectGetMinY(self.cancelButton.frame), 80, 40);
        
        self.emailField.alpha = 0.75;
        self.passwordConfirmationField.alpha = 0.75;
        self.fullnameField.alpha = 0.75;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
            self.fullnameField.alpha = 1;
            self.usernameField.alpha = 1;
            self.emailField.alpha = 1;
            self.passwordField.alpha = 1;
            self.passwordConfirmationField.alpha = 1;
        } completion:nil];
    }];
}

@end

