//
//  CardMapLister.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardMapLister.h"

@implementation CardMapLister

#pragma mark - Init

- (id) initWithListing:(id<CardMapListing>) cardMapListing withCardMapView:(UIView<CardMapViewProtocol>*) cardMapView withMapCardLister:(UIView<CardMapListerViewProtocol>*) cardMapLister
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
    NSLog(@"Show index %d", index);
}

#pragma mark - Public

- (void) startWithPrintedCards:(NSArray*) printedCards withPreLoadImageInfo:(NSArray*) preLoadImageInfo
{
    _printedCards = printedCards;
    _preLoadImageInfo = preLoadImageInfo;
    
    [self presentCardAtIndex:0];
}

@end
