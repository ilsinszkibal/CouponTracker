//
//  CCMapPosition.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMapPosition : NSObject {
    
    double longitude;
    double latitude;
    
}

@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) double latitude;

- (id) initWithLongitude:(double) longitude latitude:(double) latitude;

@end
