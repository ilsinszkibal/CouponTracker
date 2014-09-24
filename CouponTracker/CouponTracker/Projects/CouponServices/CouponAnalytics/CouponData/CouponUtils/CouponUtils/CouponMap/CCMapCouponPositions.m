//
//  CCMapCouponPositions.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMapCouponPositions.h"

@implementation CCMapCouponPositions

#pragma mark - Init

- (id) initWithCollection:(NSArray*) collection {
    
    self = [super init];
    
    if ( self )
        positionCollection = [NSArray arrayWithArray:collection];
    
    return self;
}

#pragma mark - Public

- (int) count {
    return [positionCollection count];
}

- (CCMapPosition*) positionAt:(int) index {
    
    CCMapPosition* position = nil;
    
    if ( 0 <= index && index < [positionCollection count] )
        position = [positionCollection objectAtIndex:index];
    
    return position;
}

@end
