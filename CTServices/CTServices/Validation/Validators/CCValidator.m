//
//  CCValidator.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidator.h"

@implementation CCValidator

- (instancetype)initWithValue:(id)value {
    self = [self init];
    if (self) {
        self.value = value;
    }
    return self;
}

+ (instancetype)validatorWithValue:(id)value {
    return [[self alloc] initWithValue:value];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.conditions = [NSSet set];
    }
    return self;
}

- (BOOL)validateWithErrors:(NSSet**)errors {
    NSMutableSet* errorMessages = [NSMutableSet set];
    BOOL isValid = YES;
    for (CCValidationCondition* condition in self.conditions) {
        NSError* error = nil;
        if (![condition validateWithValue:self.value error:&error]) {
            isValid = NO;
            if (error) {
                [errorMessages addObject:error];
            }
        }
    }
    if (errors != NULL) {
        *errors = errorMessages;
    }
    return isValid;
}

- (BOOL)validateWithConditions:(NSArray*)conditions errors:(NSSet**)errors {
    [self addConditions:conditions];
    return [self validateWithErrors:errors];
}

- (void)addCondition:(CCValidationCondition*)condition {
    NSMutableSet* conditions = self.conditions.mutableCopy;
    [conditions addObject:condition];
    self.conditions = conditions.copy;
}

- (void)addConditions:(NSArray*)conditions {
    for (CCValidationCondition* condition in conditions) {
        [self addCondition:condition];
    }
}

- (instancetype)initWithConditions:(NSArray*)conditions {
    self = [self init];
    if (self) {
        [self addConditions:conditions];
    }
    return self;
}

+ (instancetype)validatorWithConditions:(NSArray*)conditions {
    return [[self alloc] initWithConditions:conditions];
}

- (BOOL)validateValue:(id)value errors:(NSSet**)errors {
    self.value = value;
    return [self validateWithErrors:errors];
}

@end
