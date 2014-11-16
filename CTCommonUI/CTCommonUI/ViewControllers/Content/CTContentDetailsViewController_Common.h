//
//  CTContentDetailsViewController_Common.h
//  CTCommonUI
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

@class Model_CardContent, CTCardContentView, Model_PrintedCard;

@interface CTContentDetailsViewController_Common : CTViewController

@property (nonatomic, strong) Model_CardContent* content;
@property (nonatomic, strong) Model_PrintedCard* card;
@property (nonatomic, strong) CTCardContentView* contentView;
@property (nonatomic, strong) UIButton* handoffButton;

@property (nonatomic, assign) BOOL handoffEnabled;

- (void)navigateToHandoff;

@end
