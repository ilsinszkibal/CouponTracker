//
//  CCLengthCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCLengthCondition.h"

@interface CCLengthCondition ()

@property (nonatomic, assign) NSNumber* minValue;
@property (nonatomic, assign) NSNumber* maxValue;

@end

@implementation CCLengthCondition

- (instancetype)initWithMinLength:(NSNumber *)minValue maxLength:(NSNumber *)maxValue {
    self = [super init];
    if (self) {
        self.minValue = minValue;
        self.maxValue = maxValue;
    }
    return self;
}

+ (instancetype)conditionWithMinLength:(NSInteger)minValue {
    return [[self alloc] initWithMinLength:@(minValue) maxLength:nil];
}

+ (instancetype)conditionWithMaxLength:(NSInteger)maxValue {
    return [[self alloc] initWithMinLength:nil maxLength:@(maxValue)];
}

+ (instancetype)conditionWithLengthRange:(NSRange)range {
    return [[self alloc] initWithMinLength:@(range.location) maxLength:@(range.location+range.length)];
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
        return [self validateWithValue:number.stringValue error:error];
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ type is not implemented in this validator", [value class]]}];
        }
        return NO;
    }
}

@end