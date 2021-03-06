//
//  CTNewContentViewController_Common.h
//  CTCommonUI
//
//  Created by Teveli László on 26/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"
#import "CTContentDetailsViewController_Common.h"

@class Model_PrintedCard;

@interface CTNewContentViewController_Common : CTViewController

@property (nonatomic, assign) BOOL isHandoff; // if not creating a new card but creating a new content into an existing empty card
@property (nonatomic, assign) Model_PrintedCard* card;
@property (nonatomic, weak) CTContentDetailsViewController_Common* contentViewController;

@end
