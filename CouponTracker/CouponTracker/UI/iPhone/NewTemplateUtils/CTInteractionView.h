//
//  CTInteractionView.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 16/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTInteractionView;

@protocol CTInteracting <NSObject>

- (void) tapInteractionOnView:(CTInteractionView*) view;

@end

@interface CTInteractionView : UIView

- (id) initWithTitle:(NSString*) title withDelegate:(id<CTInteracting>) delegate;

@property (nonatomic, weak, readonly) id<CTInteracting> delegate;

@end
