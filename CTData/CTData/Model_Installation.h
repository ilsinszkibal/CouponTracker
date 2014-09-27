//
//  Model_Installation.h
//  Coupon
//
//  Created by Teveli László on 24/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_BaseEntity.h"

@interface Model_Installation : Model_BaseEntity

@property (nonatomic, strong) NSString* deviceName;
@property (nonatomic, strong) NSString* deviceId;
@property (nonatomic, strong) NSString* pushToken;
@property (nonatomic, strong) NSArray* pushChannels;
@property (nonatomic, strong) NSString* deviceType;
@property (nonatomic, strong) NSNumber* badge;
@property (nonatomic, strong) NSString* installationId;
@property (nonatomic, strong) NSString* timezone;
@property (nonatomic, strong) NSString* appVersion;
@property (nonatomic, strong) NSString* osVersion;
@property (nonatomic, strong) NSString* deviceVersion;
@property (nonatomic, strong) NSString* deviceVersionDescription;
@property (nonatomic, strong) NSString* adId;
@property (nonatomic, strong) NSString* appBuildNumber;
@property (nonatomic, strong) NSString* osName;
@property (nonatomic, strong) NSString* bundleId;
@property (nonatomic, strong) NSString* osLanguage;
@property (nonatomic, strong) NSArray* preferredLanguages;
@property (nonatomic, strong) NSString* osCountryCode;
@property (nonatomic, strong) NSString* osCurrencyCode;
@property (nonatomic, strong) NSString* osLanguageCode;
@property (nonatomic, strong) NSString* currentCountryCode;
@property (nonatomic, strong) NSString* currentCurrencyCode;
@property (nonatomic, strong) NSString* currentLanguageCode;
@property (nonatomic, strong) NSString* location;

@end
