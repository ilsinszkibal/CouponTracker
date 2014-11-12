//
//  CardMapLister.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardMapViewProtocol.h"
#import "CardMapListerViewProtocol.h"

@protocol CardMapListing <NSObject>

@end

@interface CardMapLister : NSObject {
    
    NSArray* _printedCards;
    NSArray* _preLoadImageInfo;
    
}

@property (nonatomic, weak, readonly) id<CardMapListing> cardMapListing;
@property (nonatomic, weak, readonly) UIView<CardMapListerViewProtocol>* cardMapListingView;
@property (nonatomic, weak, readonly) UIView<CardMapViewProtocol>* cardMapView;

- (id) initWithListing:(id<CardMapListing>) cardMapListing withCardMapView:(UIView<CardMapViewProtocol>*) cardMapView withMapCardLister:(UIView<CardMapListerViewProtocol>*) cardMapLister;

- (void) startWithPrintedCards:(NSArray*) printedCards withPreLoadImageInfo:(NSArray*) preLoadImageInfo;

@end
