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
#import <ReactiveCocoa/RACEXTScope.h>

@interface CTUserManager ()

@property (nonatomic, assign) BOOL storeCredentials;
@property (nonatomic, strong) AFOAuth2Client* client;

@end

@implementation CTUserManager

- (void)setUp {
    self.storeCredentials = YES;
    self.client = [AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:@"http://coupontracker.org.149-5-47-148.sg511.servergrove.com"] clientID:@"1_3y9wqmtr87ggo4c88scgscoowc0wowcskg408c0gcw0kk8cg4w" secret:@"4sn0z798juas04ko8sgkgwo80co4wwc0g844wwk84g88o8scgo"];
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
           if (block) {
               CTOauth2User* user = [[CTOauth2User alloc] init];//FIXME: get details
               [user setCredential:credential];
               block(user, nil);
           }
       } else {
           [self.client authenticateUsingOAuthWithPath:@"/oauth/v2/token" refreshToken:credential.refreshToken success:^(AFOAuthCredential *credential) {
               NSLog(@"Successful relogin (with refresh)");
               [self setCredential:credential];
               if (block) {
                   CTOauth2User* user = [[CTOauth2User alloc] init];//FIXME: get details
                   [user setCredential:credential];
                   block(user, nil);
               }
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

- (void)logout {
   [self unsetCredentials];
}

- (void)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))block {
   //TODO: call server...
}

- (void)requestPasswordResetForEmail:(NSString*)email completion:(void(^)(BOOL succeed, NSError* error))block {
   //TODO: call server...
}


- (RACSignal*)logoutSignal {
    @weakify(self);
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        self.currentUser = nil;
        [subscriber sendNext:nil];
        [subscriber sendCompleted];
        return nil;
    }];
    [signal setName:@"log out"];
    return signal;
}

- (RACSignal*)loginSignalWithUser:(CTUser*)user {
    @weakify(self);
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self loginUser:user completion:^(CTUser *user, NSError *error) {
            @strongify(self);
            if (error) {
                [subscriber sendError:error];
            } else {
                self.currentUser = user;
                [subscriber sendNext:user];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
    [signal setName:@"log in"];
    return signal;
}

- (RACSignal*)signupSignalWithUser:(CTUser*)user {
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self signupUser:user completion:^(CTUser *user, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:user];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
    [signal setName:@"sign up"];
    return signal;
}

- (RACSignal*)passwordResetSignalForEmail:(NSString*)email {
    RACSignal* signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self requestPasswordResetForEmail:email completion:^(BOOL succeed, NSError *error) {
            if (error) {
                [subscriber sendError:error];
            } else {
                [subscriber sendNext:@(succeed)];
                [subscriber sendCompleted];
            }
        }];
        return nil;
    }];
    [signal setName:@"password reset"];
    return signal;
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
