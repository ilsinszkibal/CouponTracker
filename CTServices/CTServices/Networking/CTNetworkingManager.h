//
//  CTNetworkingManager.h
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"

#import "CTServerSettings.h"

@interface CTNetworkingManager : CTBaseManager

- (NSOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion;

- (NSOperation*)getSettingsID:(void(^)(CTServerSettings* settingsID, NSError* error))completion;

- (NSOperation*)getBackgroundAnimationJSON:(void(^)(NSDictionary* settingsID, NSError* error))completion;

@end
