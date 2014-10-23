//
//  CTPassingViewNavigationViewController.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

#import "CTPassingViewNavigating.h"

@interface CTPassingViewNavigationViewController : CTViewController<CTPassingViewNavigating>

- (void) setUpTransitioningDelegates;

- (void) passingViewNavigateToViewController:(UIViewController<CTPassingViewNavigating>*) viewController forKey:(CTPassingViewNavigatingKey*) key;
- (void) passingViewNavigateToViewController:(UIViewController<CTPassingViewNavigating>*) viewController forKey:(CTPassingViewNavigatingKey*) key animated: (BOOL)flag completion:(void (^)(void))completion;

@end
