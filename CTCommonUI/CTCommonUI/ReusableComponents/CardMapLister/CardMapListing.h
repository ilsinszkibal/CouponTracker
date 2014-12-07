//
//  CardMapListing.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 07/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Model_PrintedCard;

@protocol CardMapListing <NSObject>

- (void) navigateToPrintedCard:(Model_PrintedCard*) printedCard;

@end