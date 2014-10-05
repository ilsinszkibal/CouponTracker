//
//  CCLengthCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

@interface CCLengthCondition : CCValidationCondition

- (instancetype)initWithMinLength:(NSNumber*)minValue maxLength:(NSNumber*)maxValue;
+ (instancetype)conditionWithMinLength:(NSInteger)minValue;
+ (instancetype)conditionWithMaxLength:(NSInteger)maxValue;
+ (instancetype)conditionWithLengthRange:(NSRange)range;

@end
