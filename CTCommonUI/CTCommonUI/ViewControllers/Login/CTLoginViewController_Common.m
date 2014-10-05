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

@interface CTLoginViewController_Common ()

- (UIViewController*)viewControllerForName:(NSString*)name;

@end

@implementation CTLoginViewController_Common

#pragma mark - ViewController override

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CTUserManager sharedManager].userSignal subscribeNext:^(CTUser* user) {
        //NSLog(@"New user: '%@', '%@'", user.username, user.email);
        if (user) {
            self.statusLabel.text = @"Authenticated";
            [self.loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        } else {
            self.statusLabel.text = @"Unauthenticated";
            [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        }
    }];
    
    RACSignal *validUsernameSignal = [self.usernameField.rac_textSignal map:^id(NSString *text) {
        return @([[CTUserManager sharedManager].usernameValidator validateValue:text errors:nil]);
    }];
    
    RACSignal *validPasswordSignal = [self.passwordField.rac_textSignal map:^id(NSString *text) {
        return @([[CTUserManager sharedManager].passwordValidator validateValue:text errors:nil]);
    }];
    
    RACSignal *loginActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                                                     reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                                                         return @([usernameValid boolValue] && [passwordValid boolValue]);
                                                     }];
    
    RAC(self.passwordField, backgroundColor) = [validPasswordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.usernameField, backgroundColor) = [validUsernameSignal map:^id(NSNumber *usernameValid) {
        return [usernameValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
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
        self.loginButton.enabled = NO;
        [loginSignal subscribeCompleted:^ {
            self.loginButton.enabled = YES;
        }];
    }];
    
    self.loginButton.rac_command = loginCommand;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CTUserManager sharedManager] loginWithStoredCredentialsCompletion:nil];
}

#pragma mark - IBActions

- (IBAction) loginAction:(UIButton*) button
{
    NSLog(@"Login action");
    CTUser* user = [[CTUser alloc] init];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    
    
    [[CTUserManager sharedManager] loginUser:user completion:^(CTUser *user, NSError *error) {
        
        if ( error )
        {
            
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (IBAction) notNowAction:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) registerAction:(UIButton*) sender
{
    [self showRegister];
}

#pragma mark - Public methods for showing login and register

- (void) showLogin {
}

- (void) showRegister {
}

@end

