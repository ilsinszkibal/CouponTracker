//
//  Model_CardTemplate.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_BaseEntity.h"

@class Model_CardType, Model_PrintedCard, Model_Image;

@interface Model_CardTemplate : Model_BaseEntity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Model_Image * image;
@property (nonatomic, retain) Model_CardType *type;
@property (nonatomic, retain) NSSet *cards;

@end
