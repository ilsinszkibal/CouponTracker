//
//  CTUserManager.m
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTUserManager.h"
#import <AFOAuth2Client.h>
#import <RestKit.h>
#import "CTUser.h"
#import "CCValidationManager.h"
#import "CTNetworkingManager.h"

@interface CTUserManager ()

@property (nonatomic, assign) BOOL storeCredentials;
@property (nonatomic, strong) AFOAuth2Client* client;

@end

@implementation CTUserManager

- (void)setUp {
    self.storeCredentials = YES;
    self.client = [AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:@"http://coupontracker.org.149-5-47-148.sg511.servergrove.com"] clientID:@"14_11qung55ahcgcgc8sc0s8ss40k8o8g44ww80sgg00ogsc880o8" secret:@"3n1uj47h9a68oksw84g4oscosgssswosswk08gc80s8wk4cws4"];
}

- (BOOL)storeCredential:(AFOAuthCredential*)credential {
   if (self.storeCredentials) {
       return [AFOAuthCredential storeCredential:credential withIdentifier:@"oauth"];
   } else {
       return NO;
   }
}

- (AFOAuthCredential*)retrieveCredential {
   if (self.storeCredentials) {
       return [AFOAuthCredential retrieveCredentialWithIdentifier:@"oauth"];
   } else {
       return nil;
   }
}

- (void)setCredential:(AFOAuthCredential*)credential {
   [self storeCredential:credential];
   NSString *authValue = [NSString stringWithFormat:@"Bearer %@", credential.accessToken];
   [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Authorization" value:authValue];
}

- (void)unsetCredentials {
   [AFOAuthCredential deleteCredentialWithIdentifier:@"oauth"];
   [[RKObjectManager sharedManager].HTTPClient clearAuthorizationHeader];
   
   [self setCurrentUser:nil];
}

- (void)loginUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block {
   [self.client authenticateUsingOAuthWithPath:@"/oauth/v2/token" username:user.username password:user.password scope:@"email" success:^(AFOAuthCredential *credential) {
       NSLog(@"Successful login");
       [user setLoggedIn:YES];
       [self setCredential:credential];
       [self setCurrentUser:user];
       if (block) {
           block(user, nil);
       }
   } failure:^(NSError *error) {
       NSLog(@"Error logging in: %@", error);
       if (block) {
           block(user, error);
       }
   }];
}

- (void)loginWithStoredCredentialsCompletion:(void(^)(CTUser* user, NSError* error))block {
   NSLog(@"Trying automatic relogin");
   AFOAuthCredential* credential = [self retrieveCredential];
   if (credential) {
       if (!credential.isExpired) {
           NSLog(@"Successful relogin");
           [self setCredential:credential];
           
           __block CTOauth2User* user = [[CTOauth2User alloc] init];
           [user setCredential:credential];
           self.currentUser = user;
           
          [self refreshCurrentUser:block];
       } else {
           [self.client authenticateUsingOAuthWithPath:@"/oauth/v2/token" refreshToken:credential.refreshToken success:^(AFOAuthCredential *credential) {
               NSLog(@"Successful relogin (with refresh)");
               [self setCredential:credential];
               
               __block CTOauth2User* user = [[CTOauth2User alloc] init];
               [user setCredential:credential];
               self.currentUser = user;
               
               [self refreshCurrentUser:block];
           } failure:^(NSError *error) {
               NSLog(@"Relogin token refresh failed");
               if (block) {
                   block(nil, error);
               }
           }];
       }
   } else {
       NSLog(@"No credentials found for automatic relogin");
   }
}

- (void)refreshCurrentUser:(void(^)(CTUser* user, NSError* error))block {
    __block CTUser* user = self.currentUser;
    [[CTNetworkingManager sharedManager] getCurrentUser:^(CTUser* detailedUser, NSError* error){
        if (detailedUser) {
            user.username = detailedUser.username;
            user.name = detailedUser.name;
            user.email = detailedUser.email;
        }
        if (block) {
            block(user, error);
        }
    }];
}

- (void)logout {
   [self unsetCredentials];
}

- (void)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block {
    [[CTNetworkingManager sharedManager] signupUser:user completion:block];
}

- (void)requestPasswordResetForEmail:(NSString*)email completion:(void(^)(BOOL succeed, NSError* error))block {
   //TODO: call server...
}

- (CCValidator*)usernameValidator {
    return [CCValidator validatorWithConditions:@[[CCLengthCondition conditionWithMinLength:4]]];//TODO unique condition
}

- (CCValidator*)passwordValidator {
    CCIncludingCondition* includingCondition = [CCIncludingCondition condition];
//    [includingCondition includePart:CCIncludingPartNumeric minimum:2];
//    [includingCondition includePart:CCIncludingPartUppercaseLetter minimum:1];
//    [includingCondition includePart:CCIncludingPartAlphanumeric minimum:5];
//    [includingCondition excludePart:CCIncludingPartWhitespace];
//    [includingCondition excludePhrases:[NSSet setWithArray:@[@"pass", @"asd", @"qwe", @"123"]]];
    return [CCValidator validatorWithConditions:@[[CCLengthCondition conditionWithMinLength:6], includingCondition]];
}

- (CCValidator*)emailValidator {
    return [CCValidator validatorWithConditions:@[[CCEmailCondition condition]]];
}

@end
