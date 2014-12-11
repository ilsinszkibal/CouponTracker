//
//  CTAnalytics.m
//  CTAnalytics
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTAnalytics.h"
#import <GAI.h>
#import <GAIDictionaryBuilder.h>
#import <GAIFields.h>

@implementation CTAnalytics

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initGoogleAnalytics];
    }
    return self;
}

- (void)logEvent:(NSString*)eventName
{
    [self logGoogleEvent:eventName];
}

- (void)logScreenEvent:(NSString*)eventName
{
    [self logGoogleScreenEvent:eventName];
}

#pragma mark - GoogleAnalytics

- (void)initGoogleAnalytics
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-57606502-1"];
}

- (void)logGoogleEvent:(NSString*)eventName
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"
                                                          action:eventName
                                                           label:nil
                                                           value:nil] build]];
}

- (void)logGoogleScreenEvent:(NSString*)screenName
{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end
