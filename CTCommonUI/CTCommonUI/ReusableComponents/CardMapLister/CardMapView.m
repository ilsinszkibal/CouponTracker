//
//  CardMapView.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardMapView.h"

#import "Model_PrintedCard.h"
#import "Model_CardContent.h"

#import "CardMapAnnotation.h"

@implementation CardMapView

- (CGSize) preferredContentViewSize
{
    return self.frame.size;
}

- (void) presentAnnotationsForPrintedCard:(Model_PrintedCard*) printedCard
{
    
    if ( printedCard == nil )
        return;
    
    NSMutableArray* annotationCollection = [@[] mutableCopy];
    
    CLLocationDegrees latitudes[2];
    latitudes[0] = FLT_MAX;
    latitudes[1] = FLT_MIN;
    CLLocationDegrees longitudes[2];
    longitudes[0] = FLT_MAX;
    longitudes[1] = FLT_MIN;
    
    for (Model_CardContent* content in [printedCard contents] ) {
        
        NSString* latitude = [content locationLatitude];
        NSString* longitude = [content locationLongitude];
        
        if ( 0 < [latitude length] && 0 < [longitude length] )
        {
            double actLatitude = [latitude doubleValue];
            double actLongitude = [longitude doubleValue];
            
            if ( actLatitude < latitudes[0] )
            {
                latitudes[0] = actLatitude;
            }
            if ( latitudes[1] < actLatitude )
            {
                latitudes[1] = actLatitude;
            }
            
            if ( actLongitude < longitudes[0] )
            {
                longitudes[0] = actLongitude;
            }
            if ( longitudes[1] < actLongitude )
            {
                longitudes[1] = actLongitude;
            }
            
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(actLatitude, actLongitude);
            CardMapAnnotation* annotation = [[CardMapAnnotation alloc] initWithTitle:[content text] subTitle:@"" coordinate:coordinate];
            
            [annotationCollection addObject:annotation];
        }
        
    }
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake( ( latitudes[0] + latitudes[1] ) / 2.0, ( longitudes[0] + longitudes[1] ) / 2.0 );
    
    CLLocationDegrees latitudeDelta = fabs( center.latitude - latitudes[0] ) * 1.5;
    CLLocationDegrees longitudeDelta = fabs( center.longitude - longitudes[0] ) * 1.5;
    CLLocationDegrees maxDelta = MAX(latitudeDelta, longitudeDelta);
    MKCoordinateSpan span = MKCoordinateSpanMake(maxDelta, maxDelta);
    
    [self addAnnotations:annotationCollection];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self setRegion:region animated:YES];
    
}


@end
