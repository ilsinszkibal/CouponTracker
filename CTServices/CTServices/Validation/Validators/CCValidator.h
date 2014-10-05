//
//  CCValidator.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCValidationCondition.h"

@interface CCValidator : NSObject

@property (nonatomic, strong) NSSet* conditions;
@property (nonatomic, copy) NSString* fieldName;

@property (nonatomic, strong) id value;

- (instancetype)initWithValue:(id)value;
+ (instancetype)validatorWithValue:(id)value;

- (instancetype)initWithConditions:(NSArray*)conditions;
+ (instancetype)validatorWithConditions:(NSArray*)conditions;

- (BOOL)validateWithErrors:(NSSet**)errors;
- (BOOL)validateWithConditions:(NSArray*)conditions errors:(NSSet**)errors;

- (BOOL)validateValue:(id)value errors:(NSSet**)errors;

- (void)addCondition:(CCValidationCondition*)condition;
- (void)addConditions:(NSArray*)conditions;

@end
