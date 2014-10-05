//
//  CCRegexCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCRegexCondition.h"

@interface CCRegexCondition ()

@property (nonatomic, copy) NSString* regex;

@end

@implementation CCRegexCondition

- (instancetype)initWithRegex:(NSString *)regex;
{
    self = [super init];
    if (self) {
        self.regex = regex;
    }
    return self;
}

+ (instancetype)conditionWithRegex:(NSString *)regex {
    return [[self alloc] initWithRegex:regex];
}

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if ([value isKindOfClass:[NSString class]]) {
        NSString* string = value;
        NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
        if ([test evaluateWithObject:string] == NO) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"String not matches %@", self.regex]}];
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
