//
//  CCBouncingTransition.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CTSimpleAnimatedTransition.h"

#import "CTPresentationController.h"

#import "CTBouncingAnimatedTransitioning.h"
#import "CTNavigationAnimatedTransitioning.h"
#import "CTPassingViewNavigationAnimatedTransitioning.h"

@implementation CTSimpleAnimatedTransition

#pragma mark - Factory

+ (instancetype) bouncingModalPresentationTransition
{
    
    id <UIViewControllerAnimatedTransitioning> presenting = [[CTBouncingAnimatedTransitioning alloc] initWithMoveDown:YES];
    id <UIViewControllerAnimatedTransitioning> dismissing = [[CTBouncingAnimatedTransitioning alloc] initWithMoveDown:NO];
    
    CTSimpleAnimatedTransition* animatedTransition = [[CTSimpleAnimatedTransition alloc] initWithPresentingAnimated:presenting dismissalAnimated:dismissing presentationType:PresentationTypeBouncing];
    
    return animatedTransition;
}

+ (instancetype) sideNavigationPresentationTransition
{
    
    id<UIViewControllerAnimatedTransitioning> presenting = [[CTNavigationAnimatedTransitioning alloc] initWithMoveLeft:YES];
    id<UIViewControllerAnimatedTransitioning> dismissing = [[CTNavigationAnimatedTransitioning alloc] initWithMoveLeft:NO];
    
    CTSimpleAnimatedTransition* animatedTransition = [[CTSimpleAnimatedTransition alloc] initWithPresentingAnimated:presenting dismissalAnimated:dismissing presentationType:PresentationTypeSideNavigation];
    
    return animatedTransition;
}

+ (instancetype) viewPassingNavigationPresentationTransition
{
    
    id<UIViewControllerAnimatedTransitioning> presenting = [[CTPassingViewNavigationAnimatedTransitioning alloc] initWithMoveLeft:YES];
    id<UIViewControllerAnimatedTransitioning> dismissing = [[CTPassingViewNavigationAnimatedTransitioning alloc] initWithMoveLeft:NO];
    
    CTSimpleAnimatedTransition* animatedTransition = [[CTSimpleAnimatedTransition alloc] initWithPresentingAnimated:presenting dismissalAnimated:dismissing presentationType:PresentationTypeViewPassingNavigation];
    
    return animatedTransition;
}

#pragma mark - Init

- (id) initWithPresentingAnimated:(id<UIViewControllerAnimatedTransitioning>) presentingAnimated dismissalAnimated:(id<UIViewControllerAnimatedTransitioning>) dismissalAnimated presentationType:(PresentationType) presentationType
{
    
    self = [super init];
    
    if ( self ) {
        _presentingAnimated = presentingAnimated;
        _dismissalAnimated = dismissalAnimated;
        
        _presentationType = presentationType;
    }
    
    return self;
}

#pragma mark - Transitioning delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self presentingAnimated];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self dismissalAnimated];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    if ( _presentationType == PresentationTypeBouncing )
    {
        CTPresentationController* presentationController = [[CTPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
        
        return presentationController;
    }
    
    return nil;
}

@end
