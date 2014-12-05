//
//  CardMapLister.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardMapLister.h"

#import "CardMapAnnotation.h"

#import "Model_PrintedCard.h"
#import "Model_CardContent.h"

@implementation CardMapLister

#pragma mark - Init

- (id) initWithListing:(id<CardMapListing>) cardMapListing withCardMapView:(MKMapView<CardMapViewProtocol>*) cardMapView withMapCardLister:(UIView<CardMapListerViewProtocol>*) cardMapLister
{
    
    self = [super init];
    
    if ( self ) {
        
        _cardMapListing = cardMapListing;
        _cardMapListingView = cardMapLister;
        _cardMapView = cardMapView;
        
    }
    
    return self;
}

#pragma mark - Presetings

- (void) presentCardAtIndex:(NSUInteger) index
{
    Model_PrintedCard* printedCard = _printedCards[ index ];
    
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
    
    [_cardMapView addAnnotations:annotationCollection];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [_cardMapView setRegion:region animated:YES];
    
}

- (BOOL) hasContentLocation:(Model_CardContent*) content
{
    
    NSString* latitude = [content locationLatitude];
    NSString* longitude = [content locationLongitude];
    
    return 0 < [latitude length] && 0 < [longitude length];
}

#pragma mark - Public

- (void) startWithPrintedCards:(NSArray*) printedCards withPreLoadImageInfo:(NSArray*) preLoadImageInfo
{
    
    NSMutableArray* cardsWithValidCollection = [@[] mutableCopy];
    
    for (Model_PrintedCard* card in printedCards) {
        for (Model_CardContent* content in [card contents] ) {
            
            if ( [self hasContentLocation:content] )
            {
                [cardsWithValidCollection addObject:card];
                break;
            }
            
        }
    }
    
    _printedCards = [NSArray arrayWithArray:cardsWithValidCollection];
    _preLoadImageInfo = preLoadImageInfo;
    
    if ( 0 < [_printedCards count] )
    {
        [self presentCardAtIndex:0];
    }
}

@end
