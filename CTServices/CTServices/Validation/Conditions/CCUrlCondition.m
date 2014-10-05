//
//  CCUrlCondition.m
//  Coupon
//
//  Created by Teveli László on 20/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCUrlCondition.h"

@implementation CCUrlCondition

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if ([value isKindOfClass:[NSString class]]) {
        NSString* string = value;
        if (![string hasPrefix:@"http://"] || [string hasPrefix:@"https://"]) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: @"Invalid url"}];
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
