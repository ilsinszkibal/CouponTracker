//
//  CCValidationCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

@implementation CCValidationCondition

+ (instancetype)condition {
    return [[self alloc] init];
}

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    *error = nil;
    return NO;
}

@end
