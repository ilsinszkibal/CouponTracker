//
//  CCMapPosition.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMapPosition.h"

@implementation CCMapPosition
@synthesize longitude, latitude;

#pragma mark - Init

- (id) initWithLongitude:(double) longitudeP latitude:(double) latitudeP {
    
    self = [super init];
    
    if ( self ) {
        
        longitude = longitudeP;
        latitude = latitudeP;
        
    }
    
    return self;
}

@end
