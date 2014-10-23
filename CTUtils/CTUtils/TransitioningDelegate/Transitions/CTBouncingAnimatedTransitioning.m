//
//  BouncingAnimatedTransitioning.m
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CTBouncingAnimatedTransitioning.h"

@implementation CTBouncingAnimatedTransitioning

#pragma mark - Init

- (id) initWithMoveDown:(BOOL)moveDown
{
    
    self = [super init];
    
    if ( self ) {
        _moveDown = moveDown;
    }
    
    return self;
}

#pragma mark - AnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* fromView = [fromVC view];
    UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* toView = [toVC view];
    
    UIView* containerView = [transitionContext containerView];
    
    BOOL isPresenting = [self moveDown];
    
    if(isPresenting)
    {
        [containerView addSubview:toView];
    }
    
    UIViewController* animatingVC = isPresenting? toVC : fromVC;
    UIView* animatingView = [animatingVC view];
    
    CGRect appearedFrame = [transitionContext finalFrameForViewController:animatingVC];
    CGRect dismissedFrame = appearedFrame;
    dismissedFrame.origin.y -= toView.frame.size.height;
    
    CGRect initialFrame = isPresenting ? dismissedFrame : appearedFrame;
    CGRect finalFrame = isPresenting ? appearedFrame : dismissedFrame;
    
    CGAffineTransform initTransform = isPresenting ? CGAffineTransformMakeRotation( 0.5f ) : CGAffineTransformIdentity;
    CGAffineTransform finalTransform = isPresenting ? [transitionContext targetTransform] : CGAffineTransformMakeRotation( 0.2f );
    
    [animatingView setFrame:initialFrame];
    [animatingView setTransform:initTransform];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:300.0
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [animatingView setTransform:finalTransform];
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
