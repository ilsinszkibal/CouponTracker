//
//  CCValidationCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const CCValidatorErrorDomain = @"ValidatorErrorDomain";

typedef enum {
    CCValidatorErrorCodeNotImplemented = 1,
    CCValidatorErrorCodeNotValid = 2
} CCValidatorErrorCodeType;

@interface CCValidationCondition : NSObject

+ (instancetype)condition;
- (BOOL)validateWithValue:(id)value error:(NSError**)error;

@end
