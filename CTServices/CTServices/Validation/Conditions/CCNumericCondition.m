//
//  CCNumericCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCNumericCondition.h"

@interface CCNumericCondition ()

@property (nonatomic, assign) NSNumber* minValue;
@property (nonatomic, assign) NSNumber* maxValue;

@end

@implementation CCNumericCondition

- (instancetype)initWithMinValue:(NSNumber*)minValue maxValue:(NSNumber*)maxValue {
    self = [super init];
    if (self) {
        self.minValue = minValue;
        self.maxValue = maxValue;
    }
    return self;
}

+ (instancetype)conditionWithMinValue:(NSInteger)minValue {
    return [[self alloc] initWithMinValue:@(minValue) maxValue:nil];
}

+ (instancetype)conditionWithMaxValue:(NSInteger)maxValue {
    return [[self alloc] initWithMinValue:nil maxValue:@(maxValue)];
}

+ (instancetype)conditionWithValueRange:(NSRange)range {
    return [[self alloc] initWithMinValue:@(range.location) maxValue:@(range.location+range.length)];
}

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if ([value isKindOfClass:[NSString class]]) {
        NSString* string = value;
        if (self.minValue && self.minValue.integerValue > string.length) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotValid userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"The input length is less than %ld", (long)self.minValue.integerValue]}];
            }
            return NO;
        }
        if (self.maxValue && self.maxValue.integerValue < string.length) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotValid userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"The input length is greater than %ld", (long)self.maxValue.integerValue]}];
            }
            return NO;
        }
        return YES;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber* number = value;
        if (self.minValue && self.minValue.floatValue > number.floatValue) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotValid userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"The input is less than %ld", (long)self.minValue.integerValue]}];
            }
            return NO;
        }
        if (self.maxValue && self.maxValue.floatValue < number.floatValue) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotValid userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"The input is greater than %ld", (long)self.maxValue.integerValue]}];
            }
            return NO;
        }
        return YES;
        //return [self validateWithValue:number.stringValue error:error];
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ type is not implemented in this validator", [value class]]}];
        }
        return NO;
    }
}

@end
