//
//  CCMapAnnotation.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CCMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString* title;
@property (nonatomic, readonly, copy) NSString* subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D) mapCoordinate withTitle:(NSString*) annotationTitle withSubTitle:(NSString*) annotationSubTitle;

@end
