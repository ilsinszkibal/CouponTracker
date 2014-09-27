//
//  Model_Installation.m
//  Coupon
//
//  Created by Teveli László on 24/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "Model_Installation.h"
#import <CoreLocation/CoreLocation.h>
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>

@implementation Model_Installation

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIDevice* device = [UIDevice currentDevice];
        UIApplication* application = [UIApplication sharedApplication];
        NSDictionary* infoDictrionary = [[NSBundle mainBundle] infoDictionary];
        self.deviceName = device.name;
        self.deviceType = device.model;
//        self.deviceVersion = device.modelIdentifier;
//        self.deviceVersionDescription = device.modelName;
        self.deviceId = [device.identifierForVendor UUIDString];
        self.pushToken = nil;
        self.pushChannels = nil;
        self.createdAt = [NSDate date];
        self.updatedAt = nil;
        self.badge = @(application.applicationIconBadgeNumber);
        self.installationId = [device.identifierForVendor UUIDString];
        self.adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        self.timezone = [NSTimeZone systemTimeZone].name;
        self.appVersion = [infoDictrionary objectForKey:@"CFBundleShortVersionString"];
        self.appBuildNumber = [infoDictrionary objectForKey:@"CFBundleVersion"];
        self.osName = device.systemName;
        self.osVersion = device.systemVersion;
        self.bundleId = [[NSBundle mainBundle] bundleIdentifier];
        self.osLanguage = [NSLocale preferredLanguages].firstObject;
        self.preferredLanguages = [NSLocale preferredLanguages];
        self.osCountryCode = [[NSLocale systemLocale] objectForKey:NSLocaleCountryCode];
        self.osCurrencyCode = [[NSLocale systemLocale] objectForKey:NSLocaleCurrencyCode];
        self.osLanguageCode = [[NSLocale systemLocale] objectForKey:NSLocaleLanguageCode];
        self.currentCountryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
        self.currentCurrencyCode = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencyCode];
        self.currentLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
        CLLocationManager* locationManager = [[CLLocationManager alloc] init];
        CLLocation *location = [locationManager location];
        CLLocationCoordinate2D coordinate = [location coordinate];
        self.location = [NSString stringWithFormat:@"%f, %f", coordinate.latitude, coordinate.longitude];
    }
    return self;
}

@end
