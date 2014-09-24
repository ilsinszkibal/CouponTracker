//
//  CCMapCouponPositions.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCMapPosition;

@interface CCMapCouponPositions : NSObject {
    
    NSArray* positionCollection;
    
}

- (id) initWithCollection:(NSArray*) collection;

- (int) count;
- (CCMapPosition*) positionAt:(int) index;

@end
