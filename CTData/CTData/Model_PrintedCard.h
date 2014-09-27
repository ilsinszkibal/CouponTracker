//
//  Model_PrintedCard.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Model_BaseEntity.h"

@class Model_CardContent, Model_CardRead, Model_CardTemplate;

@interface Model_PrintedCard : Model_BaseEntity

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSSet *reads;
@property (nonatomic, retain) Model_CardTemplate *template;
@property (nonatomic, retain) NSSet *contents;

@end
