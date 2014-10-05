//
//  CTMyTemplatesViewController_iPad.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_Common.h"

@interface CTMyTemplatesViewController_iPad : CTMyTemplatesViewController_Common

@property (nonatomic, weak) IBOutlet UIButton* backButton;

- (IBAction) backButtonAction:(UIButton*) backButton;

@end
