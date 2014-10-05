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
#import <ReactiveCocoa.h>
#import "CTTwoStateButton.h"

@interface CTLoginViewController_Common ()

@property (nonatomic, strong) UITextField* usernameField;
@property (nonatomic, strong) UITextField* fullnameField;
@property (nonatomic, strong) UITextField* emailField;
@property (nonatomic, strong) UITextField* passwordField;
@property (nonatomic, strong) UITextField* passwordConfirmationField;

@property (nonatomic, strong) UILabel* statusLabel;
@property (nonatomic, strong) UIButton* actionButton;
@property (nonatomic, strong) UIButton* cancelButton;
@property (nonatomic, strong) CTTwoStateButton* switchButton;

@property (nonatomic, assign) CTLoginViewState currentState;

@property (nonatomic, strong) RACCommand* loginCommand;
@property (nonatomic, strong) RACCommand* registerCommand;

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
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    self.usernameField = [[UITextField alloc] init];
    [self.usernameField setPlaceholder:@"username"];
    [self.view addSubview:self.usernameField];
    
    self.fullnameField = [[UITextField alloc] init];
    [self.fullnameField setPlaceholder:@"full name"];
    [self.view addSubview:self.fullnameField];
    
    self.emailField = [[UITextField alloc] init];
    [self.emailField setPlaceholder:@"email address"];
    [self.view addSubview:self.emailField];
    
    self.passwordField = [[UITextField alloc] init];
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setPlaceholder:@"password"];
    [self.view addSubview:self.passwordField];
    
    self.passwordConfirmationField = [[UITextField alloc] init];
    [self.passwordConfirmationField setSecureTextEntry:YES];
    [self.passwordConfirmationField setPlaceholder:@"confirmation"];
    [self.view addSubview:self.passwordConfirmationField];
    
    self.statusLabel = [[UILabel alloc] init];
    [self.view addSubview:self.statusLabel];
    
    self.actionButton = [[UIButton alloc] init];
    [self.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
    
    [[CTUserManager sharedManager].userSignal subscribeNext:^(CTUser* user) {
        if (self.currentState == CTLoginViewStateLogin) {
            if (user) {
                self.statusLabel.text = @"Authenticated";
                [self.actionButton setTitle:@"Logout" forState:UIControlStateNormal];
            } else {
                self.statusLabel.text = @"Unauthenticated";
                [self.actionButton setTitle:@"Login" forState:UIControlStateNormal];
            }
        } else if (self.currentState == CTLoginViewStateRegister) {
            if (user) {
                self.statusLabel.text = @"Success";
                [self.actionButton setTitle:@"Logout" forState:UIControlStateNormal];
            } else {
                self.statusLabel.text = @"";
                [self.actionButton setTitle:@"Register" forState:UIControlStateNormal];
            }
        }
    }];
    
    [self setupFieldsValidation];
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
        self.actionButton.rac_command = self.loginCommand;
    } else if (state == CTLoginViewStateRegister) {
        [self.actionButton setTitle:@"Register" forState:UIControlStateNormal];
        [self.switchButton setCurrentState:CTButtonStateActive];
        [self setupRegisterViews];
        self.actionButton.rac_command = self.registerCommand;
    } else if (state == CTLoginViewStateForgot) {
        //TODO:
    }
}

#pragma mark - Actions

- (void) actionButtonPressed:(UIButton*) button {
    if (self.currentState == CTLoginViewStateLogin) {
        CTUser* user = [[CTUser alloc] init];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        [[CTUserManager sharedManager] loginUser:user completion:^(CTUser *user, NSError *error) {
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

- (void)setupFieldsValidation {
    #pragma mark validation signals
    
    RACSignal *validUsernameSignal = [self.usernameField.rac_textSignal map:^id(NSString *text) {
        return @([[CTUserManager sharedManager].usernameValidator validateValue:text errors:nil]);
    }];
    
    RACSignal *validFullnameSignal = [self.fullnameField.rac_textSignal map:^id(NSString *text) {
        CCValidationCondition* length = [CCLengthCondition conditionWithMinLength:4];
        CCIncludingCondition* space = [CCIncludingCondition condition];
        [space includePart:CCIncludingPartWhitespace minimum:1];
        return @([[CCValidator validatorWithConditions:@[length, space]] validateValue:text errors:nil]);
    }];
    
    RACSignal *validPasswordSignal = [self.passwordField.rac_textSignal map:^id(NSString *text) {
        return @([[CTUserManager sharedManager].passwordValidator validateValue:text errors:nil]);
    }];
    
    RACSignal *validPasswordConfirmSignal = [self.passwordConfirmationField.rac_textSignal map:^id(NSString *text) {
        CCMatchingCondition* match = [CCMatchingCondition conditionMatchesValue:self.passwordField.text];
        CCRequiredCondition* notEmpty = [CCRequiredCondition condition];
        return @([[CCValidator validatorWithConditions:@[match, notEmpty]] validateValue:text errors:nil]);
    }];
    
    RACSignal *validEmailSignal = [self.emailField.rac_textSignal map:^id(NSString *text) {
        return @([[CTUserManager sharedManager].emailValidator validateValue:text errors:nil]);
    }];
    
    RACSignal *loginActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validFullnameSignal, validEmailSignal, validPasswordSignal, validPasswordConfirmSignal] reduce:^id(NSNumber *usernameValid, NSNumber *fullnameValid, NSNumber *emailValid, NSNumber *passwordValid, NSNumber *confirmValid) {
        return @([usernameValid boolValue] && [fullnameValid boolValue] && [emailValid boolValue] && [passwordValid boolValue] && [confirmValid boolValue]);
    }];
    
    #pragma mark field colorization
    
    RAC(self.usernameField, backgroundColor) = [validUsernameSignal map:^id(NSNumber *valid) {
        return [valid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.emailField, backgroundColor) = [validEmailSignal map:^id(NSNumber *valid) {
        return [valid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.fullnameField, backgroundColor) = [validFullnameSignal map:^id(NSNumber *valid) {
        return [valid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.passwordField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *valid) {
        return [valid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.passwordConfirmationField, backgroundColor) = [validPasswordConfirmSignal map:^id(NSNumber *valid) {
        return [valid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    #pragma mark button command
    
    RACCommand* registerCommand = [[RACCommand alloc] initWithEnabled:loginActiveSignal signalBlock:^RACSignal *(UIButton* loginButton) {
        [self.usernameField resignFirstResponder];
        [self.fullnameField resignFirstResponder];
        [self.emailField resignFirstResponder];
        [self.passwordField resignFirstResponder];
        [self.passwordConfirmationField resignFirstResponder];
        
        CTUser* user = [[CTUser alloc] init];
        user.username = self.usernameField.text;
        user.name = self.fullnameField.text;
        user.email = self.emailField.text;
        user.password = self.passwordField.text;
        
        return [[CTUserManager sharedManager] signupSignalWithUser:user];
    }];
    
    [registerCommand.executionSignals subscribeNext:^(RACSignal* loginSignal) {
        self.actionButton.enabled = NO;
        [loginSignal subscribeCompleted:^ {
            self.actionButton.enabled = YES;
        }];
    }];
    
    self.registerCommand = registerCommand;
    
    RACCommand* loginCommand = [[RACCommand alloc] initWithEnabled:loginActiveSignal signalBlock:^RACSignal *(UIButton* loginButton) {
        [self.usernameField resignFirstResponder];
        [self.passwordField resignFirstResponder];
        if ([[CTUserManager sharedManager].currentUser isLoggedIn]) {
            return [[CTUserManager sharedManager] logoutSignal];
        } else {
            CTUser* user = [[CTUser alloc] init];
            user.username = self.usernameField.text;
            user.password = self.passwordField.text;
            return [[CTUserManager sharedManager] loginSignalWithUser:user];
        }
    }];
    
    [loginCommand.executionSignals subscribeNext:^(RACSignal* loginSignal) {
        self.actionButton.enabled = NO;
        [loginSignal subscribeCompleted:^ {
            self.actionButton.enabled = YES;
        }];
    }];
    
    self.loginCommand = loginCommand;
}

#pragma mark - Setup

- (void)setupLoginViews {
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        self.usernameField.frame = CGRectMake(10, 60, 200, 35);
        self.passwordField.frame = CGRectMake(10, CGRectGetMaxY(self.usernameField.frame) + 10, 200, 35);
        
        self.fullnameField.frame = self.usernameField.frame;
        self.emailField.frame = self.usernameField.frame;
        self.passwordConfirmationField.frame = self.passwordField.frame;
        
        self.switchButton.frame = CGRectMake(10, CGRectGetMaxY(self.passwordField.frame) + 10, 80, 40);
        self.cancelButton.frame = CGRectMake(CGRectGetMaxX(self.switchButton.frame) + 10, CGRectGetMinY(self.switchButton.frame), 100, 40);
        self.actionButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, CGRectGetMinY(self.cancelButton.frame), 60, 40);

        self.emailField.alpha = 0;
        self.passwordConfirmationField.alpha = 0;
        self.fullnameField.alpha = 0;
    } completion:nil];
}

- (void)setupRegisterViews {
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        self.fullnameField.frame = CGRectMake(10, 10, 200, 35);
        self.usernameField.frame = CGRectMake(10, CGRectGetMaxY(self.fullnameField.frame) + 10, 200, 35);
        self.emailField.frame = CGRectMake(10, CGRectGetMaxY(self.usernameField.frame) + 10, 200, 35);
        self.passwordField.frame = CGRectMake(10, CGRectGetMaxY(self.emailField.frame) + 10, 200, 35);
        self.passwordConfirmationField.frame = CGRectMake(10, CGRectGetMaxY(self.passwordField.frame) + 10, 200, 35);
        
        self.switchButton.frame = CGRectMake(10, CGRectGetMaxY(self.passwordConfirmationField.frame) + 10, 60, 40);
        self.cancelButton.frame = CGRectMake(CGRectGetMaxX(self.switchButton.frame) + 10, CGRectGetMinY(self.switchButton.frame), 100, 40);
        self.actionButton.frame = CGRectMake(CGRectGetMaxX(self.cancelButton.frame) + 10, CGRectGetMinY(self.cancelButton.frame), 80, 40);
        
        self.emailField.alpha = 0.5;
        self.passwordConfirmationField.alpha = 0.5;
        self.fullnameField.alpha = 0.5;
    } completion:nil];
}

@end

