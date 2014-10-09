//
//  BorderContainerView.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreferredViewSizing.h"

@interface BorderContainerView : UIView<PreferredViewSizing>

@property (nonatomic, readonly) UIView<PreferredViewSizing>* contentView;

- (id) initWithContentView:(UIView<PreferredViewSizing>*) contentView;

- (CGFloat) containerMargin;
- (CGSize) preferredContainterViewSize;

@end
