//
//  CTViewController.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTViewController : UIViewController

- (void) showLogin;
- (void) showRegister;

- (void) setUpTransitioningDelegates;

- (void) navigateToViewController:(UIViewController*) viewController;
- (void) navigateToViewController:(UIViewController*) viewController animated: (BOOL)flag completion:(void (^)(void))completion;

@end
