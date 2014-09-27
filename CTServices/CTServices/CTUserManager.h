//
//  CTUserManager.h
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"

@class CTUser, CTOauth2User;

@interface CTUserManager : CTBaseManager

@property (nonatomic, strong) CTUser* currentUser;

- (void)loginUser:(CTOauth2User*)user completion:(void(^)(CTOauth2User* user, NSError* error))block;
- (void)loginWithStoredCredentialsCompletion:(void(^)(CTUser* user, NSError* error))block;
- (void)logout;
- (void)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block;
- (void)requestPasswordResetForEmail:(NSString*)email completion:(void(^)(BOOL succeed, NSError* error))block;

@end
