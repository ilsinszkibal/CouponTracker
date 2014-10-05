//
//  CTUserManager.h
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"
#import <ReactiveCocoa.h>

@class CTUser, CTOauth2User, CCValidator;

@interface CTUserManager : CTBaseManager

@property (nonatomic, strong) CTUser* currentUser;

- (void)loginUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block;
- (void)loginWithStoredCredentialsCompletion:(void(^)(CTUser* user, NSError* error))block;
- (void)logout;
- (void)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block;
- (void)requestPasswordResetForEmail:(NSString*)email completion:(void(^)(BOOL succeed, NSError* error))block;

@property (nonatomic, strong) RACSignal* userSignal;

- (RACSignal*)logoutSignal;
- (RACSignal*)loginSignalWithUser:(CTUser*)user;
- (RACSignal*)signupSignalWithUser:(CTUser*)user;
- (RACSignal*)passwordResetSignalForEmail:(NSString*)email;

- (CCValidator*)usernameValidator;
- (CCValidator*)passwordValidator;
- (CCValidator*)emailValidator;

@end
