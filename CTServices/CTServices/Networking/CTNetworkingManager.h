//
//  CTNetworkingManager.h
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"
#import "CTServerSettings.h"
#import <UIKit/UIKit.h>

@class Model_Image, Model_CardRead, Model_CardTemplate, Model_PrintedCard, CTUser;

@interface CTNetworkingManager : CTBaseManager

- (NSOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion;
- (NSOperation*)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion;
- (NSOperation*)readCardWithCode:(NSString*)code completion:(void(^)(Model_CardRead* card, NSError* error))completion;

- (NSOperation*)createTemplateWithName:(NSString*)name text:(NSString*)text image:(UIImage*)image completion:(void(^)(Model_CardTemplate* image, NSError* error))completion;
- (NSOperation*)createPrintedCardFromTemplate:(Model_CardTemplate*)template completion:(void(^)(Model_PrintedCard* card, NSError* error))completion;

- (NSOperation*)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))completion;

- (NSOperation*)getMyTemplates:(void(^)(NSArray* templates, NSError* error))completion;
- (NSOperation*)getPopularTemplates:(void(^)(NSArray* templates, NSError* error))completion;

- (NSOperation*)getSettingsID:(void(^)(CTServerSettings* settingsID, NSError* error))completion;

- (NSOperation*)getBackgroundAnimationJSON:(void(^)(NSDictionary* settingsID, NSError* error))completion;

@end
