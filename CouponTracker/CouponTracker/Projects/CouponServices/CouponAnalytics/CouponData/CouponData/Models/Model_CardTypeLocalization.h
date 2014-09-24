//
//  Model_CardTypeLocalization.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model_BaseEntity.h"

@class Model_CardType, Model_Language;

@interface Model_CardTypeLocalization : Model_BaseEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Model_CardType *type;
@property (nonatomic, retain) Model_Language *language;

@end
