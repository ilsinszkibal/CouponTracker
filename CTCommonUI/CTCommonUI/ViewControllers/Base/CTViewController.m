//
//  CTViewController.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

#import "CTColor.h"

#import "CTLoginViewController_Common.h"

#import "CTSimpleAnimatedTransition.h"

#import "CTBouncingAnimatedTransitioning.h"
#import "CTLoginViewController_Common.h"

@interface CTViewController ()

@property (nonatomic, strong) CTSimpleAnimatedTransition* transition;
@property (nonatomic, strong) CTSimpleAnimatedTransition* navigationTransitioning;

@end

@implementation CTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
    
    [self setUpTransitioningDelegates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setup

- (void) setUpTransitioningDelegates
{
    self.transition = [CTSimpleAnimatedTransition bouncingModalPresentationTransition];
    self.navigationTransitioning = [CTSimpleAnimatedTransition sideNavigationPresentationTransition];
}

#pragma mark - Login and registration

- (void) showLogin
{
    UIViewController* login = [[CTLoginViewController_Common alloc] init];
    [self showViewController:login animated:YES];
}

- (void) showRegister
{
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        
    } completion:nil];
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL) animated {
    
    viewController.transitioningDelegate = self.transition;
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:animated completion:nil];
}

#pragma mark - Navigation

- (void) navigateToViewController:(UIViewController*) viewController
{
    [self navigateToViewController:viewController animated:YES completion:NULL];
}

- (void) navigateToViewController:(UIViewController*) viewController animated: (BOOL)flag completion:(void (^)(void))completion
{
    [viewController setTransitioningDelegate:self.navigationTransitioning];
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
