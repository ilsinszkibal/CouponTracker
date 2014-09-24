//
//  CCMapPageControlView.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCMapPageControlView.h"

#import "CCMapView.h"

@implementation CCMapPageControlView

#pragma mark - Private

- (void) _refreshMapView {
    
    CCMapCouponPositions* couponPositions = nil;
    
    if ( 0 <= selectedPositionCollectionIndex && selectedPositionCollectionIndex < [positionCollection count] )
        couponPositions = [positionCollection objectAtIndex:selectedPositionCollectionIndex];
    
    
    [mapView refreshMapWithPosition:couponPositions];
}

- (void) _refreshPageControl {
    
    if ( 0 < [positionCollection count] ) {
        [pageControl setHidden:FALSE];
        
        [pageControl setCurrentPage:selectedPositionCollectionIndex];
        [pageControl setNumberOfPages:[positionCollection count] ];
        
    }
    else
        [pageControl setHidden:TRUE];
    
}

- (void) _invalidateTimer {
    [positionSwitchTimer invalidate];
    positionSwitchTimer = nil;
}

- (void) _fireTimer {
    
    //Invalidate
    if ( [positionCollection count] == 0 )
        [self _invalidateTimer];
    
    //Check if need to switch
    if ( toBiggerIndex && [positionCollection count] <= ( selectedPositionCollectionIndex + 1 ) )
        toBiggerIndex = FALSE;
    else if ( toBiggerIndex == FALSE && ( selectedPositionCollectionIndex - 1) < 0 )
        toBiggerIndex = TRUE;
    
    //Move
    if ( toBiggerIndex )
        selectedPositionCollectionIndex++;
    else
        selectedPositionCollectionIndex--;
    
    if ( 0 <= selectedPositionCollectionIndex && selectedPositionCollectionIndex < [positionCollection count] ) {
        [self _refreshMapView];
        [self _refreshPageControl];
    }
    else
        [self _invalidateTimer];
    
}

- (void) _updateTimer {

    [self _invalidateTimer];
    
    if ( [positionCollection count] == 0 )
        return;
    
    positionSwitchTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(_fireTimer) userInfo:nil repeats:TRUE];
    toBiggerIndex = TRUE;
}

#pragma mark - Public

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setBackgroundColor:[UIColor grayColor] ];
    
    int pageControlHeight = 50;
    
    CGRect mapViewRect = CGRectZero;
    mapViewRect.size = frame.size;
    mapViewRect.size.height -= pageControlHeight;
    mapViewRect = CGRectIntegral( mapViewRect );
    if ( mapView == nil ) {
        mapView = [[CCMapView alloc] initWithFrame:mapViewRect];
        [self addSubview:mapView];
    }
    else
        [mapView setFrame:mapViewRect];
    
    CGRect pageControlRect = CGRectZero;
    pageControlRect.size = frame.size;
    pageControlRect.origin.y = pageControlRect.size.height - pageControlHeight;
    pageControlRect.size.height = pageControlHeight;
    pageControlRect = CGRectIntegral( pageControlRect );
    if ( pageControl == nil ) {
        pageControl = [[UIPageControl alloc] initWithFrame:pageControlRect];
        [pageControl setPageIndicatorTintColor:[UIColor greenColor] ];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor] ];
        [self addSubview:pageControl];
    }
    else
        [pageControl setFrame:pageControlRect];
    
    [self _refreshPageControl];
}

- (void) updatePositionCollection:(NSArray*) positionCollectionP {
    
    positionCollection = [NSArray arrayWithArray:positionCollectionP];
    
    if ( 0 < [positionCollection count] )
        selectedPositionCollectionIndex = 0;
    else
        selectedPositionCollectionIndex = -1;
    
    [self _refreshMapView];
    [self _refreshPageControl];
    [self _updateTimer];
}

@end
