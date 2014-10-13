//
//  CTPassingViewNavigationViewController.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPassingViewNavigationViewController.h"

#import "CTSimpleAnimatedTransition.h"
#import "CTPassingViewNavigationAnimatedTransitioning.h"

@interface CTPassingViewNavigationViewController ()

@property (nonatomic, strong) CTSimpleAnimatedTransition* passingViewTransitioning;

@end

@implementation CTPassingViewNavigationViewController

#pragma mark - UIViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTransitioningDelegates];
}

- (void) setUpTransitioningDelegates
{
    self.passingViewTransitioning = [CTSimpleAnimatedTransition viewPassingNavigationPresentationTransition];
}

#pragma mark - CTPassingViewNavigating protocol

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    return nil;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    return CGRectZero;
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    
}

#pragma mark - PassingViewNavigation

- (void) passingViewNavigateToViewController:(UIViewController<CTPassingViewNavigating>*) viewController forKey:(CTPassingViewNavigatingKey*) key
{
    [self passingViewNavigateToViewController:viewController forKey:key animated:YES completion:nil];
}

- (void) passingViewNavigateToViewController:(UIViewController<CTPassingViewNavigating>*) viewController forKey:(CTPassingViewNavigatingKey*) key animated: (BOOL)flag completion:(void (^)(void))completion
{
    
    if ( [self.passingViewTransitioning.presentingAnimated isKindOfClass:[CTPassingViewNavigationAnimatedTransitioning class] ] == NO || [self.passingViewTransitioning.dismissalAnimated isKindOfClass:[CTPassingViewNavigationAnimatedTransitioning class] ] == NO )
    {
        return;
    }
    
    CTPassingViewNavigationAnimatedTransitioning* presenting = (CTPassingViewNavigationAnimatedTransitioning*)self.passingViewTransitioning.presentingAnimated;
    CTPassingViewNavigationAnimatedTransitioning* dismissing = (CTPassingViewNavigationAnimatedTransitioning*)self.passingViewTransitioning.dismissalAnimated;
    
    [presenting setNavigationKey:key];
    [dismissing setNavigationKey:key];
    
    [viewController setTransitioningDelegate:self.passingViewTransitioning];
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:flag completion:nil];
}

@end
