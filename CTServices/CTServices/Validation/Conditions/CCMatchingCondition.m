//
//  CCMatchingCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMatchingCondition.h"

@interface CCMatchingCondition ()

@property (nonatomic, strong) id matchValue;

@end

@implementation CCMatchingCondition

+ (instancetype) conditionMatchesValue:(id)value {
    return [[self alloc] initWithMatchValue:value];
}

- (instancetype)initWithMatchValue:(id)value {
    self = [super init];
    if (self) {
        self.matchValue = value;
    }
    return self;
}

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if (!value) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: @"Input is required"}];
        }
        return NO;
    }
    if ([value isKindOfClass:[NSString class]] && [self.matchValue isKindOfClass:[NSString class]]) {
        NSString* string = value;
        if (![string isEqualToString:self.matchValue]) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: @"String must be identical to the other value"}];
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
