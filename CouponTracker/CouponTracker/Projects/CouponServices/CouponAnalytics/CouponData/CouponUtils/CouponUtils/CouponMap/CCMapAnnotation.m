//
//  CCMapAnnotation.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMapAnnotation.h"

@implementation CCMapAnnotation
@synthesize coordinate, title, subtitle;

#pragma mark - Init

- (id) initWithCoordinate:(CLLocationCoordinate2D) mapCoordinate withTitle:(NSString*) annotationTitle withSubTitle:(NSString*) annotationSubTitle {
    
    self = [super init];
    
    if ( self ) {
        
        coordinate = mapCoordinate;
        title = annotationTitle;
        subtitle = annotationSubTitle;
        
    }
    
    return self;
}

@end
