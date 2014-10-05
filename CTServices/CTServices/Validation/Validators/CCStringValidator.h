//
//  CCStringValidator.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidator.h"

@interface CCStringValidator : CCValidator

@property (nonatomic, strong) NSString* value;

- (instancetype)initWithString:(NSString*)string;
+ (instancetype)validatorWithString:(NSString*)string;

@end
