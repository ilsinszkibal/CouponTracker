//
//  CCFormValdator.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidator.h"

@interface CCFormValdator : NSObject

@property (nonatomic, strong) NSSet* fields;

- (instancetype)initWithFields:(NSArray*)fields;
+ (instancetype)validatorWithFields:(NSArray*)fields;

- (BOOL)validateWithErrors:(NSDictionary**)errors;

- (void)addField:(CCValidator*)field;
- (void)addFields:(NSSet*)fields;

@end
