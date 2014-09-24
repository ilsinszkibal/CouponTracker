//
//  CCDataManager.h
//  SplashApp
//
//  Created by Teveli László on 2013.11.03..
//  Copyright (c) 2013 László Teveli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Model.h"

@class CCServerStore;

@interface CCDataManager : NSObject

- (void)test;
- (void)getCards;
- (void)getMyCardWithCompletion:(void(^)(NSArray* result, NSError* error))completion;
- (void)getPromotedCardsWithCompletion:(void(^)(NSArray* result, NSError* error))completion;
- (void)getCardContents:(int) cardID withCompletion:(void(^)(NSArray* result, NSError* error))completion;

- (void)getTemplates;
- (void)readCardWithCode:(NSString*)code completion:(void(^)(Model_CardRead* read, NSError* error))completion;
- (void)getCardForCode:(NSString*)code completion:(void(^)(Model_PrintedCard* card, NSError* error))completion;
- (void)getUrlForImageId:(NSNumber*)identifier completion:(void(^)(NSURL* url, NSError* error))completion;
- (void)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion;

@end
