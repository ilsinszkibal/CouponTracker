//
//  CTLocationManager.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 09/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <INTULocationManager.h>

@interface CTLocationManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL) locationServicesAvailable;
- (CLLocation*) lastLocation;

- (NSInteger)requestLocationWithDesiredAccuracy:(INTULocationAccuracy)desiredAccuracy
                                        timeout:(NSTimeInterval)timeout
                                          block:(INTULocationRequestBlock)block;

- (NSInteger)requestLocationWithDesiredAccuracy:(INTULocationAccuracy)desiredAccuracy
                                        timeout:(NSTimeInterval)timeout
                           delayUntilAuthorized:(BOOL)delayUntilAuthorized
                                          block:(INTULocationRequestBlock)block;

- (void)forceCompleteLocationRequest:(NSInteger)requestID;

- (void)cancelLocationRequest:(NSInteger)requestID;

@end
