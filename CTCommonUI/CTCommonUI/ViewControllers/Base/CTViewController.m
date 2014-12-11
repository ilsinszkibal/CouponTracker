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
    UIButton* _bottomLeftButton;
    UIButton* _bottomRightButton;
    
    UILabel* _middleLabel;
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
    
    [_loadingIndicator removeFromSuperview];
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_loadingIndicator setHidden:YES];
    [self.view addSubview:_loadingIndicator];
    
    [_middleLabel removeFromSuperview];
    _middleLabel = [[UILabel alloc] init];
    [_middleLabel setTextColor:[UIColor whiteColor] ];
    [_middleLabel setHidden:YES];
    [self.view addSubview:_middleLabel];
    
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
    
    if ( [_middleLabel isHidden] == NO )
    {
        [_middleLabel sizeToFit];
        [_middleLabel setFrame:CGRectIntegral( CGRectMake(self.view.width / 2.0 - _middleLabel.width / 2.0, self.view.height / 2.0 - _middleLabel.height / 2.0, _middleLabel.width, _middleLabel.height) ) ];
    }
    
    [_loadingIndicator setFrame: CGRectIntegral( CGRectMake(self.view.width / 2.0 - _loadingIndicator.width / 2.0, self.view.height / 2.0 - _loadingIndicator.height / 2.0, _loadingIndicator.width, _loadingIndicator.height) )];
    
}

#pragma mark - Orientation

- (BOOL) shouldAutorotate
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations
{
    if ( [DeviceInfo isiPhone] )
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    
    return UIInterfaceOrientationMaskAll;
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

- (void) setUpBottomLeftButtonWithTitle:(NSString*) title withSel:(SEL) selector
{
    [_bottomLeftButton removeFromSuperview];
    _bottomLeftButton = [UIFactory defaultButtonWithTitle:title target:self action:selector];
    [self.view addSubview:_bottomLeftButton];
}

- (void) setUpBottomRightButtonWithTitle:(NSString*) title withSel:(SEL) selector
{
    [_bottomRightButton removeFromSuperview];
    _bottomRightButton = [UIFactory defaultButtonWithTitle:title target:self action:selector];
    [self.view addSubview:_bottomRightButton];
}

- (void) setTopButtoniPadPositions
{
    CGFloat margin = 10;
    
    [_topLeftButton setFrame:CGRectMake(margin, 25, 150, 44) ];
    [_topRightButton setFrame:CGRectMake(self.view.frame.size.width - 150 - 10, 25, 150, 44) ];
    [_bottomLeftButton setFrame:CGRectMake(margin, self.view.height - 25 - 44, 150, 44) ];
    [_bottomRightButton setFrame:CGRectMake(self.view.width - 150 - 10, self.view.height - 25 - 44, 150, 44) ];
}

- (void) setTopButtoniPhonePositions
{
    CGFloat margin = 10;
    
    [_topLeftButton setFrame:CGRectMake(margin, 25, 100, 30) ];
    [_topRightButton setFrame:CGRectMake(self.view.frame.size.width - 100 - 10, 25, 100, 30) ];
    [_bottomLeftButton setFrame:CGRectMake(margin, self.view.height - 25 - 44, 100, 30) ];
    [_bottomRightButton setFrame:CGRectMake(self.view.width - 100 - 10, self.view.height - 25 - 44, 100, 30) ];
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

- (void) showMiddleTextLabel:(NSString*) text;
{
    [_middleLabel setText:text];
    [_middleLabel setHidden:NO];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void) hideMiddleTextLabel;
{
    [_middleLabel setText:@""];
    [_middleLabel setHidden:YES];
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
