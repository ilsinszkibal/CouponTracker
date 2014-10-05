//
//  CCRequiredCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCRequiredCondition.h"

@implementation CCRequiredCondition

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if (!value) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: @"Input is required"}];
        }
        return NO;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString* string = value;
        if ([string isEqualToString:@""]) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: @"String must not be empty"}];
            }
            return NO;
        }
        return YES;
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ type is not implemented in this validator", [value class]]}];
        }
        return NO;
    }
}

@end
