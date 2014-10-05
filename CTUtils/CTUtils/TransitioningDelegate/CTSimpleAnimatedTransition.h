//
//  CCBouncingTransition.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PresentationTypeBouncing,
    PresentationTypeSideNavigation,
} PresentationType;

@interface CTSimpleAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, readonly) id<UIViewControllerAnimatedTransitioning> presentingAnimated;
@property (nonatomic, readonly) id<UIViewControllerAnimatedTransitioning> dismissalAnimated;
@property (nonatomic, readonly) PresentationType presentationType;

+ (instancetype) bouncingModalPresentationTransition;
+ (instancetype) sideNavigationPresentationTransition;

- (id) initWithPresentingAnimated:(id<UIViewControllerAnimatedTransitioning>) presentingAnimated dismissalAnimated:(id<UIViewControllerAnimatedTransitioning>) dismissalAnimated presentationType:(PresentationType) presentationType;

@end
