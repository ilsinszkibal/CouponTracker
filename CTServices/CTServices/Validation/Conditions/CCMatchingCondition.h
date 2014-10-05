//
//  CCMatchingCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

@interface CCMatchingCondition : CCValidationCondition

+ (instancetype) conditionMatchesValue:(id)value;

@end
