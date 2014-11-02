//
//  CTComposeViewController.m
//  CTCommonUI
//
//  Created by Teveli László on 02/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTComposeViewController.h"

@implementation CTComposeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hasAttachment = YES;
        self.attachmentImage = [UIImage imageNamed:@"scan2"];
        [self.navigationBar setBackgroundColor:[UIColor orangeColor]];
    }
    return self;
}

- (void)didTapAttachmentView:(id)sender {
    //DO NOTHING
}

@end
