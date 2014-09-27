//
//  Model_BaseEntity.h
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model_BaseEntity : NSObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * createdBy;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * deleted;

@end
