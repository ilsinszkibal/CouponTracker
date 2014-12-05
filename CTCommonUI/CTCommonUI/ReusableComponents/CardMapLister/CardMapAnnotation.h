//
//  CardMapAnnotation.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 18/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface CardMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

-(id) initWithTitle:(NSString*) title subTitle:(NSString*) subTitle coordinate:(CLLocationCoordinate2D) coordinate;

@end
