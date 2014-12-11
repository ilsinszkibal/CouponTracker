//
//  CTPrintTemplateViewController_Common.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPassingViewNavigationViewController.h"

@class Model_CardTemplate;

@interface CTPrintTemplateViewController_Common : CTPassingViewNavigationViewController

@property (nonatomic, strong) Model_CardTemplate* template;

- (void)print;
- (void)print:(UIButton*) button;

@end
