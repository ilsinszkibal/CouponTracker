//
//  CCFormValdator.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCFormValdator.h"

@implementation CCFormValdator

- (instancetype)initWithFields:(NSArray *)fields {
    self = [self init];
    if (self) {
        self.fields = [NSSet setWithArray:fields];
    }
    return self;
}

+ (instancetype)validatorWithFields:(NSArray *)fields {
    return [[self alloc] initWithFields:fields];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fields = [NSSet set];
    }
    return self;
}

- (BOOL)validateWithErrors:(NSDictionary**)errors {
    NSMutableDictionary* errorMessages = [NSMutableDictionary dictionary];
    BOOL isValid = YES;
    for (CCValidator* field in self.fields) {
        NSSet* errors = nil;
        if (![field validateWithErrors:&errors]) {
            isValid = NO;
            [errorMessages setObject:errors forKey:field.fieldName];
        }
    }
    if (errors != NULL) {
        *errors = errorMessages;
    }
    return isValid;
}

- (void)addField:(CCValidator *)field {
    NSMutableSet* conditions = self.fields.mutableCopy;
    [conditions addObject:field];
    self.fields = conditions.copy;
}

- (void)addFields:(NSSet *)fields {
    for (CCValidator* field in fields) {
        [self addField:field];
    }
}


@end
