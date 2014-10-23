//
//  CTPassingViewNavigationAnimatedTransitioning.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTPassingViewNavigatingKey.h"

@interface CTPassingViewNavigationAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly) BOOL moveLeft;
@property (nonatomic, strong) CTPassingViewNavigatingKey* navigationKey;

- (id) initWithMoveLeft:(BOOL) moveLeft;

@end
