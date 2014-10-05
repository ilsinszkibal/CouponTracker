//
//  BouncingAnimatedTransitioning.h
//  Coupon
//
//  Created by Balazs Ilsinszki on 13/09/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTBouncingAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly) BOOL moveDown;

- (id) initWithMoveDown:(BOOL) moveDown;

@end
