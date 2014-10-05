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
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView = [fromVC view];
    UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = [toVC view];
    
    UIView* containerView = [transitionContext containerView];
    
    BOOL isPresenting = [self moveLeft];
    
    if(isPresenting)
    {
        [containerView addSubview:toView];
    }
    
    UIViewController* animatingVC = isPresenting? toVC : fromVC;
    UIView* animatingView = [animatingVC view];
    
    CGRect appearedFrame = [transitionContext finalFrameForViewController:animatingVC];
    CGRect dismissedFrame = appearedFrame;
    dismissedFrame.origin.x += toView.frame.size.width;
    
    CGRect initialFrame = isPresenting ? dismissedFrame : appearedFrame;
    CGRect finalFrame = isPresenting ? appearedFrame : dismissedFrame;
    
    [animatingView setFrame:initialFrame];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:300.0
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [animatingView setFrame:finalFrame];
                     }
                     completion:^(BOOL finished){
                         if(!isPresenting)
                         {
                             [fromView removeFromSuperview];
                         }
                         [transitionContext completeTransition:YES];
                     }];
    
}

@end
