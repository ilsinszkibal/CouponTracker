//
//  CCRegexCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

@interface CCRegexCondition : CCValidationCondition

- (instancetype)initWithRegex:(NSString*)regex;
+ (instancetype)conditionWithRegex:(NSString*)regex;

@end
