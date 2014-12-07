//
//  CardMapListerViewProtocol.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardMapListing.h"

@class Model_PrintedCard;

@protocol CardMapListerViewProtocol <NSObject>

- (void) presentPrintedCard:(Model_PrintedCard*) printedCard;
- (void) setCardMapListing:(id<CardMapListing>) cardMapListing;

@end
