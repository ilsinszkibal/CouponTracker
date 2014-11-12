//
//  CTViewController.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTViewController : UIViewController

- (void) setUpTopLeftButtonWithTitle:(NSString*) title withSel:(SEL) selector;
- (void) setUpTopRightButtonWithTitle:(NSString*) title withSel:(SEL) selector;
- (void) setUpBottomLeftButtonWithTitle:(NSString*) title withSel:(SEL) selector;
- (void) setUpBottomRightButtonWithTitle:(NSString*) title withSel:(SEL) selector;

- (void) startMiddleLoadingIndicator;
- (void) stopMiddleLoadingIndicator;


- (BOOL) isUserLoggedIn;
- (void) showLogin;
- (void) showRegister;

- (void) setUpTransitioningDelegates;

- (void) navigateToViewController:(UIViewController*) viewController;
- (void) navigateToViewController:(UIViewController*) viewController animated: (BOOL)flag completion:(void (^)(void))completion;

@end
