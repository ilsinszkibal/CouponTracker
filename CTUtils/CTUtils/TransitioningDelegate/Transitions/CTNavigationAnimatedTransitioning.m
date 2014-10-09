//
//  CTNaviagationAnimatedTransitioning.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNavigationAnimatedTransitioning.h"

@implementation CTNavigationAnimatedTransitioning

#pragma mark - Init

- (id) initWithMoveLeft:(BOOL) moveLeft
{
    
    self = [super init];
    
    if ( self ) {
        _moveLeft = moveLeft;
    }
    
    return self;
}

#pragma mark - AnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if ( [self moveLeft] )
    {
        [self presentAnimation:transitionContext];
    }
    else
    {
        [self dismissAnimation:transitionContext];
    }
    
}

- (void) presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //CurrentViewController
    UIViewController* currentViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* currentView = [currentViewController view];
    CGRect currentViewFinalRect = [transitionContext finalFrameForViewController:currentViewController];
    currentViewFinalRect.origin.x -= currentViewFinalRect.size.width;
    
    //PresentingViewController
    UIViewController* presentingViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* presentingView = [presentingViewController view];
    CGRect presentingFinalRect = [transitionContext finalFrameForViewController:presentingViewController];
    CGRect presentingInitialRect = presentingFinalRect;
    presentingInitialRect.origin.x += presentingInitialRect.size.width;
    
    //Add view to presenting
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:presentingView];
    
    //Set the initial presenting position
    [presentingView setFrame:presentingInitialRect];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:300.0
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [presentingView setFrame:presentingFinalRect];
                         [currentView setFrame:currentViewFinalRect];
                     }
                     completion:^(BOOL finished){
                         
                         //Make sure current isn't visible
                         [currentView setAlpha:0.0f];
                         
                         //Need to transitionContext for completed transition
                         [transitionContext completeTransition:YES];
                     }];
    
}

- (void) dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //DismissingViewController
    UIViewController* dismissingViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* dismissingView = [dismissingViewController view];
    CGRect dismissingFinalRect = dismissingView.frame;
    dismissingFinalRect.origin.x += dismissingFinalRect.size.width;
    
    //OriginalViewController
    UIViewController* originalViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* originalView = [originalViewController view];
    CGRect originalFinalRect = [transitionContext finalFrameForViewController:originalViewController];
    
    //Make sure original is visible again
    [originalView setAlpha:1.0f];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:300.0
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [dismissingView setFrame:dismissingFinalRect];
                         [originalView setFrame:originalFinalRect];
                     }
                     completion:^(BOOL finished){
                         
                         [dismissingView removeFromSuperview];
                         
                         //Need to transitionContext for completed transition
                         [transitionContext completeTransition:YES];
                     }];
    
}

@end
