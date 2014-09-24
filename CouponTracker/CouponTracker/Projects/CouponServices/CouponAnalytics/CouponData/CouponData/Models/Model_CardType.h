//
//  Model_CardType.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model_BaseEntity.h"

@class Model_CardTemplate;

@interface Model_CardType : Model_BaseEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *templates;
@end

@interface Model_CardType (CoreDataGeneratedAccessors)

- (void)addTemplatesObject:(Model_CardTemplate *)value;
- (void)removeTemplatesObject:(Model_CardTemplate *)value;
- (void)addTemplates:(NSSet *)values;
- (void)removeTemplates:(NSSet *)values;

@end
