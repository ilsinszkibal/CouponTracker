//
//  CCMapView.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <MapKit/MapKit.h>

@class CCMapCouponPositions;

@interface CCMapView : MKMapView<MKMapViewDelegate> {
    
    CCMapCouponPositions* couponPosition;
    
    NSArray* mapAnnotations;
    
}

- (void) refreshMapWithPosition:(CCMapCouponPositions*) couponPosition;

@end
