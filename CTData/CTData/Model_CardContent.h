//
//  Model_CardContent.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model_BaseEntity.h"

@class Model_PrintedCard;

@interface Model_CardContent : Model_BaseEntity

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSArray* images;
@property (nonatomic, retain) NSArray* videos;
@property (nonatomic, retain) NSArray* urls;
@property (nonatomic, retain) NSString * locationLatitude;
@property (nonatomic, retain) NSString * locationLongitude;
@property (nonatomic, retain) Model_PrintedCard *card;

@end
