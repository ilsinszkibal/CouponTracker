//
//  CardMapAnnotation.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 18/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardMapAnnotation.h"

@implementation CardMapAnnotation

-(id) initWithTitle:(NSString*) title subTitle:(NSString*) subTitle coordinate:(CLLocationCoordinate2D) coordinate
{
    
    self = [super init];
    
    if ( self ) {
        
        _title = title;
        _subtitle = subTitle;
        _coordinate = coordinate;
        
    }
    
    return self;
}

@end
