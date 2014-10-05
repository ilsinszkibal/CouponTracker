//
//  CCNumericCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

@interface CCNumericCondition : CCValidationCondition

- (instancetype)initWithMinValue:(NSNumber*)minValue maxValue:(NSNumber*)maxValue;
+ (instancetype)conditionWithMinValue:(NSInteger)minValue;
+ (instancetype)conditionWithMaxValue:(NSInteger)maxValue;
+ (instancetype)conditionWithValueRange:(NSRange)range;

@end
