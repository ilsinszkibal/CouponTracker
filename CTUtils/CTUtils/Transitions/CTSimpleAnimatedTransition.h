//
//  CCBouncingTransition.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSimpleAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, readonly) id<UIViewControllerAnimatedTransitioning> presentingAnimated;
@property (nonatomic, readonly) id<UIViewControllerAnimatedTransitioning> dismissalAnimated;

- (id) initWithPresentingAnimated:(id<UIViewControllerAnimatedTransitioning>) presentingAnimated dismissalAnimated:(id<UIViewControllerAnimatedTransitioning>) dismissalAnimated;

@end
