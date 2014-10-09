//
//  CTWelcomeAnimationProperties.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTWelcomeAnimationProperties : NSObject

@property (nonatomic, readonly) CGSize imageSize;

@property (nonatomic, readonly) CGPoint preAnimationOffset;
@property (nonatomic, readonly) CGPoint postAnimationOffset;

@property (nonatomic, assign) BOOL isAnimating;

+ (instancetype) createOpeningAnimationForImageSize:(CGSize) imageSize;

- (id) initWithImageSize:(CGSize) imageSize preAnimationOffset:(CGPoint) preAnimationOffset postAnimationOffset:(CGPoint) postAnimationOffset;

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize;
- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize;

@end
