//
//  Model_Image.h
//  Coupon
//
//  Created by Teveli László on 21/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "Model_BaseEntity.h"

@interface Model_Image : Model_BaseEntity

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* name;

@end
