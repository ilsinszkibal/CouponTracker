//
//  Model_CardRead.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model_BaseEntity.h"

@class Model_PrintedCard;

@interface Model_CardRead : Model_BaseEntity

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * locationLatitude;
@property (nonatomic, retain) NSString * locationLongitude;
@property (nonatomic, retain) Model_PrintedCard *card;

@end
