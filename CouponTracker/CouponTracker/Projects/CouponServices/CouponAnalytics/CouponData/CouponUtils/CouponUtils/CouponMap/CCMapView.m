//
//  CCMapView.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMapView.h"

#import "CCMapCouponPositions.h"

#import "CCMapPosition.h"
#import "CCMapAnnotation.h"

@implementation CCMapView

#pragma mark - Init

- (id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        self.delegate = self;
        
        [self setMapType:MKMapTypeStandard];
        [self setZoomEnabled:YES];
        [self setScrollEnabled:YES];
    }
    
    return self;
}

#pragma mark - Public

- (void) refreshMapWithPosition:(CCMapCouponPositions*) couponPositionP {
    
    [self removeAnnotations:mapAnnotations];
    couponPosition = couponPositionP;
    
    if ( [couponPosition count] == 0 )
        return;
    
    NSMutableArray* tempCollection = [NSMutableArray new];
    for (int act = 0; act < [couponPosition count]; act++) {
        CCMapPosition* mapPosition = [couponPosition positionAt:act];
        
        CLLocationCoordinate2D coordinates;
        coordinates.latitude = [mapPosition latitude];
        coordinates.longitude = [mapPosition longitude];
        
        CCMapAnnotation* annotation = [[CCMapAnnotation alloc] initWithCoordinate:coordinates withTitle:[NSString stringWithFormat:@"%d title", act] withSubTitle:@"SubTitle"];
        [tempCollection addObject:annotation];
        
    }
    
    mapAnnotations = [NSArray arrayWithArray:tempCollection];
    [self addAnnotations:mapAnnotations];
    
    //Set visibilty to multiple
    CLLocationCoordinate2D firstLocation;
    CLLocationCoordinate2D maxLongitudeDistance;
    maxLongitudeDistance.longitude = 0;
    
    CLLocationCoordinate2D maxLatitudeDistance;
    maxLatitudeDistance.latitude = 0;
    
    for (int act = 0; act < [couponPosition count]; act++) {
        CCMapPosition* mapPosition = [couponPosition positionAt:act];
        
        CLLocationCoordinate2D coordinates;
        coordinates.latitude = [mapPosition latitude];
        coordinates.longitude = [mapPosition longitude];
        
        if ( act == 0 )
            firstLocation = coordinates;
        else {
            
            if ( maxLatitudeDistance.latitude < coordinates.latitude )
                maxLatitudeDistance = coordinates;
            
            if ( maxLongitudeDistance.longitude < coordinates.longitude )
                maxLongitudeDistance = coordinates;
            
        }
        
    }
    
    CLLocationCoordinate2D centerLocation;
    centerLocation.longitude = ( firstLocation.longitude + maxLongitudeDistance.longitude ) / 2.0;
    centerLocation.latitude = ( firstLocation.latitude + maxLatitudeDistance.latitude ) / 2.0;
    
    [self setCenterCoordinate:centerLocation];
        
    MKCoordinateSpan span;
    span.latitudeDelta = fabs( centerLocation.latitude - maxLatitudeDistance.latitude ) + 0.1;
    span.longitudeDelta = fabs( centerLocation.longitude - maxLongitudeDistance.longitude ) + 0.1;
        
    MKCoordinateRegion region = MKCoordinateRegionMake(centerLocation, span);
    [self setRegion:region];
    
}

@end
