//
//  CTPassingViewNavigationAnimatedTransitioning.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPassingViewNavigationAnimatedTransitioning.h"

#import "CTNavigationAnimatedTransitioning.h"

#import "CTPassingViewNavigating.h"

@interface CTPassingViewNavigationAnimatedTransitioning () {
    CTNavigationAnimatedTransitioning* _presentFallbackTransition;
    CTNavigationAnimatedTransitioning* _dismissFallbackTransition;
}

@end

@implementation CTPassingViewNavigationAnimatedTransitioning

#pragma mark - Init

- (id) initWithMoveLeft:(BOOL) moveLeft
{
    
    self = [super init];
    
    if ( self ) {
        _moveLeft = moveLeft;
        
        _presentFallbackTransition = [[CTNavigationAnimatedTransitioning alloc] initWithMoveLeft:YES];
        _dismissFallbackTransition = [[CTNavigationAnimatedTransitioning alloc] initWithMoveLeft:NO];
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
    UIViewController* currentViewControllerCandidate = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* presentingViewControllerCandidate = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ( [currentViewControllerCandidate conformsToProtocol:@protocol(CTPassingViewNavigating)] && [presentingViewControllerCandidate conformsToProtocol:@protocol(CTPassingViewNavigating)] )
    {
        
        UIViewController<CTPassingViewNavigating>* currentViewController = (UIViewController<CTPassingViewNavigating>*)currentViewControllerCandidate;
        UIViewController<CTPassingViewNavigating>* presentingViewController = (UIViewController<CTPassingViewNavigating>*) presentingViewControllerCandidate;
     
        //CurrentViewController
        UIView* currentView = [currentViewController view];
        CGRect currentViewFinalRect = [transitionContext finalFrameForViewController:currentViewController];
        currentViewFinalRect.origin.x -= currentViewFinalRect.size.width;
        
        //PresentingViewController
        UIView* presentingView = [presentingViewController view];
        CGRect presentingFinalRect = [transitionContext finalFrameForViewController:presentingViewController];
        CGRect presentingInitialRect = presentingFinalRect;
        presentingInitialRect.origin.x += presentingInitialRect.size.width;
        
        //Add view to presenting
        UIView* containerView = [transitionContext containerView];
        [containerView addSubview:presentingView];
        
        UIView* passingView = [currentViewController passingViewForKey:_navigationKey];
        if ( passingView )
        {
            [passingView setFrame:[currentViewController passingViewRectForKey:_navigationKey] ];
            [containerView addSubview:passingView];
        }
        
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
                             
                             [passingView setFrame:[presentingViewController passingViewRectForKey:_navigationKey] ];
                         }
                         completion:^(BOOL finished){
                             
                             //Make sure current isn't visible
                             [currentView setAlpha:0.0f];
                             
                             //
                             [passingView removeFromSuperview];
                             [presentingViewController receivingView:passingView forKey:_navigationKey];
                             
                             //Need to transitionContext for completed transition
                             [transitionContext completeTransition:YES];
                         }];
        
    }
    else
    {
        //Fallback logic
        [_presentFallbackTransition animateTransition:transitionContext];
    }
    
}

- (void) dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController* dismissingViewControllerCandidate = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* originalViewControllerCandidate   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ( [dismissingViewControllerCandidate conformsToProtocol:@protocol(CTPassingViewNavigating)] && [originalViewControllerCandidate conformsToProtocol:@protocol(CTPassingViewNavigating)] )
    {
        
        UIViewController<CTPassingViewNavigating>* dismissingViewController = (UIViewController<CTPassingViewNavigating>*)dismissingViewControllerCandidate;
        UIViewController<CTPassingViewNavigating>* originalViewController = (UIViewController<CTPassingViewNavigating>*) originalViewControllerCandidate;
     
        //DismissingViewController
        UIView* dismissingView = [dismissingViewController view];
        CGRect dismissingFinalRect = dismissingView.frame;
        dismissingFinalRect.origin.x += dismissingFinalRect.size.width;
        
        //OriginalViewController
        UIView* originalView = [originalViewController view];
        CGRect originalFinalRect = [transitionContext finalFrameForViewController:originalViewController];
        
        //Make sure original is visible again
        [originalView setAlpha:1.0f];
        
        //Add view to presenting
        UIView* containerView = [transitionContext containerView];
        
        UIView* passingView = [dismissingViewController passingViewForKey:_navigationKey];
        if ( passingView )
        {
            [passingView setFrame:[dismissingViewController passingViewRectForKey:_navigationKey] ];
            [containerView addSubview:passingView];
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:300.0
              initialSpringVelocity:5.0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [dismissingView setFrame:dismissingFinalRect];
                             [originalView setFrame:originalFinalRect];
                             
                             [passingView setFrame:[originalViewController passingViewRectForKey:_navigationKey] ];
                         }
                         completion:^(BOOL finished){
                             
                             [dismissingView removeFromSuperview];
                             
                             [passingView removeFromSuperview];
                             [originalViewController receivingView:passingView forKey:_navigationKey];
                             
                             //Need to transitionContext for completed transition
                             [transitionContext completeTransition:YES];
                         }];
        
    }
    else
    {
        //Fallback logic
        [_dismissFallbackTransition animateTransition:transitionContext];
    }
    
}

@end
