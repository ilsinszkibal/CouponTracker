//
//  Model_CardType.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_BaseEntity.h"

@class Model_CardTemplate;

@interface Model_CardType : Model_BaseEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *templates;

@end