//
//  CCBouncingTransition.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CTSimpleAnimatedTransition.h"
#import "CTPresentationController.h"

@implementation CTSimpleAnimatedTransition

#pragma mark - Init

- (id) initWithPresentingAnimated:(id<UIViewControllerAnimatedTransitioning>) presentingAnimated dismissalAnimated:(id<UIViewControllerAnimatedTransitioning>) dismissalAnimated
{
    
    self = [super init];
    
    if ( self ) {
        _presentingAnimated = presentingAnimated;
        _dismissalAnimated = dismissalAnimated;
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

 /*
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    
}
*/

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    
    CTPresentationController* presentationController = [[CTPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    return presentationController;
}

@end
