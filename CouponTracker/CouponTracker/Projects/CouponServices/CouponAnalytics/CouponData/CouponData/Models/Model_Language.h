//
//  Model_Language.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model_BaseEntity.h"

@class Model_CardTypeLocalization;

@interface Model_Language : Model_BaseEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSSet *localizations;
@end

@interface Model_Language (CoreDataGeneratedAccessors)

- (void)addLocalizationsObject:(Model_CardTypeLocalization *)value;
- (void)removeLocalizationsObject:(Model_CardTypeLocalization *)value;
- (void)addLocalizations:(NSSet *)values;
- (void)removeLocalizations:(NSSet *)values;

@end
