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
@property (nonatomic, readonly) CGFloat preAnimationImagePercent;

@property (nonatomic, readonly) CGPoint postAnimationOffset;
@property (nonatomic, readonly) CGFloat postAnimationImagePercent;

@property (nonatomic, readonly) CGFloat waitingBeforeAnimation;
@property (nonatomic, readonly) CGFloat animationDuration;

@property (nonatomic, readonly) CGFloat waitingBeforeAlphaAnimation;
@property (nonatomic, readonly) CGFloat alphaAnimationDuration;

@property (nonatomic, readonly) UIColor* postAnimationColor;

@property (nonatomic, assign) BOOL isAnimating;

+ (instancetype) createOpeningAnimationForImageSize:(CGSize)imageSize withDictionary:(NSDictionary*) dictionary;

- (id) initWithImageSize:(CGSize) imageSize preOffset:(CGPoint) preOffset preImagePercent:(CGFloat) prePercent postOffset:(CGPoint) postOffset postImagePercent:(CGFloat) postPercent;

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize;
- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize;

- (CGSize) preAnimationImageSize;
- (CGSize) postAnimationImageSize;

@end
