//
//  CTWelcomeAnimationProperties.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTWelcomeAnimationPosition.h"

@interface CTWelcomeAnimationProperties : NSObject

@property (nonatomic, readonly) CGSize imageSize;

@property (nonatomic, readonly) CTWelcomeAnimationPosition* portraitPosition;
@property (nonatomic, readonly) CTWelcomeAnimationPosition* landscapePosition;

@property (nonatomic, readonly) CGFloat waitingBeforeAnimation;
@property (nonatomic, readonly) CGFloat animationDuration;

@property (nonatomic, readonly) CGFloat waitingBeforeAlphaAnimation;
@property (nonatomic, readonly) CGFloat alphaAnimationDuration;

@property (nonatomic, readonly) UIColor* postAnimationColor;

@property (nonatomic, assign) BOOL isAnimating;

+ (instancetype) createOpeningAnimationForImageSize:(CGSize)imageSize withDictionary:(NSDictionary*) dictionary;

- (id) initWithImageSize:(CGSize) imageSize portraitPosition:(CTWelcomeAnimationPosition*) portraitPosition landscapePosition:(CTWelcomeAnimationPosition*) landscapePosition;

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize isPortrait:(BOOL) isPortrait;
- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize isPortrait:(BOOL) isPortrait;

- (CGSize) preAnimationImageSizeIsPortrait:(BOOL) isPortrait;
- (CGSize) postAnimationImageSizeIsPortrait:(BOOL) isPortrait;

@end
