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

#import "CTUserManager.h"

#import "CTBouncingAnimatedTransitioning.h"
#import "CTLoginViewController_Common.h"

#import "DeviceInfo.h"
@interface CTViewController () {
   
    UIButton* _topLeftButton;
    UIButton* _topRightButton;
    
    UIActivityIndicatorView* _loadingIndicator;
    
}

@property (nonatomic, strong) CTSimpleAnimatedTransition* transition;
@property (nonatomic, strong) CTSimpleAnimatedTransition* navigationTransitioning;

@end

@implementation CTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
    
    [self setUpTransitioningDelegates];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_loadingIndicator setHidden:YES];
    [self.view addSubview:_loadingIndicator];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ( [DeviceInfo isiPhone] )
    {
        [self setTopButtoniPhonePositions];
    }
    else
    {
        [self setTopButtoniPadPositions];
    }
    
    [_loadingIndicator setFrame: CGRectIntegral( CGRectMake(self.view.width / 2.0 - _loadingIndicator.width, 0, _loadingIndicator.frame.size.width, _loadingIndicator.frame.size.height) )];
    
}

#pragma mark - Setup

- (void) setUpTransitioningDelegates
{
    self.transition = [CTSimpleAnimatedTransition bouncingModalPresentationTransition];
    self.navigationTransitioning = [CTSimpleAnimatedTransition sideNavigationPresentationTransition];
}

#pragma mark - NavigationButtons

- (void) setUpTopLeftButtonWithTitle:(NSString*) title withSel:(SEL) selector
{
    [_topLeftButton removeFromSuperview];
    _topLeftButton = [UIFactory defaultButtonWithTitle:title target:self action:selector];
    [self.view addSubview:_topLeftButton];
}

- (void) setUpTopRightButtonWithTitle:(NSString*) title withSel:(SEL) selector
{
    [_topRightButton removeFromSuperview];
    _topRightButton = [UIFactory defaultButtonWithTitle:title target:self action:selector];
    [self.view addSubview:_topRightButton];
}

- (void) setTopButtoniPadPositions
{
    CGFloat margin = 10;
    
    [_topLeftButton setFrame:CGRectMake(margin, 25, 150, 44) ];
    [_topRightButton setFrame:CGRectMake(self.view.frame.size.width - 150 - 10, 25, 150, 44) ];
}

- (void) setTopButtoniPhonePositions
{
    CGFloat margin = 10;
    
    [_topLeftButton setFrame:CGRectMake(margin, 25, 100, 44) ];
    [_topRightButton setFrame:CGRectMake(self.view.frame.size.width - 100 - 10, 25, 100, 44) ];
}

#pragma mark - Loading indicator

- (void) startMiddleLoadingIndicator
{
    [_loadingIndicator setHidden:NO];
    [_loadingIndicator startAnimating];
}

- (void) stopMiddleLoadingIndicator
{
    [_loadingIndicator setHidden:YES];
    [_loadingIndicator stopAnimating];
}

#pragma mark - Login and registration

- (BOOL) isUserLoggedIn
{
    return [[CTUserManager sharedManager] currentUser] != nil;
}

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
    [self presentViewController:viewController animated:flag completion:nil];
}

@end
