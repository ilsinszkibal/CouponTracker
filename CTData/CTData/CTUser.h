//
//  CTUser.h
//  CTData
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFOAuth2Client.h>
#import "Model_BaseEntity.h"

@interface CTUser : Model_BaseEntity

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* email;

@property (nonatomic, assign, getter = isLoggedIn) BOOL loggedIn;

@end

@interface CTOauth2User : CTUser

@property (nonatomic, strong) AFOAuthCredential* credential;

@end