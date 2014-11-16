//
//  CardMapView.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "CardMapViewProtocol.h"
#import "PreferredViewSizing.h"

@interface CardMapView : MKMapView<CardMapViewProtocol, PreferredViewSizing>

@end
