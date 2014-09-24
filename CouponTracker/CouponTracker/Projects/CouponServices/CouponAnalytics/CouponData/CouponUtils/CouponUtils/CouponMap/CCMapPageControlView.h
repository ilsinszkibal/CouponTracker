//
//  CCMapPageControlView.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 27/04/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCMapView;

@interface CCMapPageControlView : UIView {
    
    int selectedPositionCollectionIndex;
    NSArray* positionCollection;
    
    CCMapView* mapView;
    UIPageControl* pageControl;
    
    NSTimer* positionSwitchTimer;
    BOOL toBiggerIndex;
    
}

- (void) updatePositionCollection:(NSArray*) positionCollection;

@end
