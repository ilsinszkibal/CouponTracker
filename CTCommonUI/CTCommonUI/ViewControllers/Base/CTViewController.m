//
//  CTViewController.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"
#import "CTLoginViewController_Common.h"
#import "CTSimpleAnimatedTransition.h"
#import "CTBouncingAnimatedTransitioning.h"

@interface CTViewController ()

@property (nonatomic, strong) CTSimpleAnimatedTransition* transition;

@end

@implementation CTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Login and registration

- (void) showLogin
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle] ];
    UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
    [self showViewController:viewController animated:YES];
}

- (void) showRegister
{
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:10 initialSpringVelocity:2 options:0 animations:^{
        
    } completion:nil];
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL) animated {
    id <UIViewControllerAnimatedTransitioning> presenting = [[CTBouncingAnimatedTransitioning alloc] initWithMoveDown:YES];
    id <UIViewControllerAnimatedTransitioning> dismissing = [[CTBouncingAnimatedTransitioning alloc] initWithMoveDown:NO];
    
    self.transition = [[CTSimpleAnimatedTransition alloc] initWithPresentingAnimated:presenting dismissalAnimated:dismissing];
    [viewController setTransitioningDelegate:self.transition];
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:animated completion:nil];
}

@end
