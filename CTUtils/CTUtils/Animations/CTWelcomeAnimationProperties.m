//
//  CTWelcomeAnimationProperties.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTWelcomeAnimationProperties.h"

#import "DeviceInfo.h"
#import "CGExtensions.h"

struct AnimationPosition {
    CGPoint offset;
    CGFloat imagePercent;
};

struct AnimationDuration {
    CGFloat waitBefore;
    CGFloat duration;
};

@interface CTWelcomeAnimationProperties ()

@property (nonatomic) CGFloat waitingBeforeAnimation;
@property (nonatomic) CGFloat animationDuration;

@property (nonatomic) CGFloat waitingBeforeAlphaAnimation;
@property (nonatomic) CGFloat alphaAnimationDuration;

@property (nonatomic) UIColor* postAnimationColor;

@end

@implementation CTWelcomeAnimationProperties

#pragma mark - Factory method

+ (instancetype) createOpeningAnimationForImageSize:(CGSize)imageSize withDictionary:(NSDictionary*) dictionary
{    
    struct AnimationPosition prePortraitPosition = [self animationPosition:dictionary[ [self preAnimationPortraitPositionKey] ] ];
    struct AnimationPosition postPortraitPosition = [self animationPosition:dictionary[ [self postAnimationPortraitPosition] ] ];
    
    //Normalize because json is in pixels
    prePortraitPosition.offset = CGPointMultiply(prePortraitPosition.offset, 1.0f / [DeviceInfo screenScale] );
    postPortraitPosition.offset = CGPointMultiply(postPortraitPosition.offset, 1.0f / [DeviceInfo screenScale] );
    
    struct AnimationPosition preLandscapePosition = [self animationPosition:dictionary[ [self preAnimationLandscapePositionKey] ] ];
    struct AnimationPosition postLandscapePosition = [self animationPosition:dictionary[ [self postAnimationLandscapePosition] ] ];
    
    //Normalize because json is in pixels
    preLandscapePosition.offset = CGPointMultiply(preLandscapePosition.offset, 1.0f / [DeviceInfo screenScale] );
    postLandscapePosition.offset = CGPointMultiply(postLandscapePosition.offset, 1.0f / [DeviceInfo screenScale] );
    
    struct AnimationDuration movingAnimation = [self animationDuration:dictionary[ [self moveAnimationDurationKey] ] ];
    struct AnimationDuration alphaAnimation = [self animationDuration:dictionary[ [self alphaAnimationDurationKey] ] ];
    
    
    //Create positions
    CTWelcomeAnimationPosition* portraitPosition = [CTWelcomeAnimationPosition positionWithPreOffset:prePortraitPosition.offset withPrePercent:prePortraitPosition.imagePercent withPostOffset:postPortraitPosition.offset withPostPercent:postPortraitPosition.imagePercent];
    CTWelcomeAnimationPosition* landscapePosition = [CTWelcomeAnimationPosition positionWithPreOffset:preLandscapePosition.offset withPrePercent:preLandscapePosition.imagePercent withPostOffset:postLandscapePosition.offset withPostPercent:postLandscapePosition.imagePercent];
    
    //Create animation
    CTWelcomeAnimationProperties* animation = [[CTWelcomeAnimationProperties alloc] initWithImageSize:imageSize portraitPosition:portraitPosition landscapePosition:landscapePosition];
    
    animation.waitingBeforeAnimation = movingAnimation.waitBefore;
    animation.animationDuration = movingAnimation.duration;
    
    animation.waitingBeforeAlphaAnimation = alphaAnimation.waitBefore;
    animation.alphaAnimationDuration = alphaAnimation.duration;
    
    animation.postAnimationColor = [self postAnimationColor:dictionary[ [self postAnimationColorKey] ] ];
    
    return animation;
}

#pragma mark - Converters

+ (UIColor*) postAnimationColor:(NSDictionary*) dictionary
{
    CGFloat r = [dictionary[ @"r" ] floatValue];
    CGFloat g = [dictionary[ @"g" ] floatValue];
    CGFloat b = [dictionary[ @"b" ] floatValue];
    CGFloat a = [dictionary[ @"a" ] floatValue];

    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (struct AnimationDuration) animationDuration:(NSDictionary*) dictionary
{
    struct AnimationDuration duration;
 
    duration.waitBefore = [dictionary[ [self waitBeforeAnimationKey] ] floatValue];
    duration.duration = [dictionary[ [self durationKey] ] floatValue];
    
    return duration;
}

+ (struct AnimationPosition) animationPosition:(NSDictionary*) dictionary
{
    struct AnimationPosition position;
    
    position.offset.x = [dictionary[ [self offsetXKey] ] floatValue];
    position.offset.y = [dictionary[ [self offsetYKey] ] floatValue];
    
    position.imagePercent = [dictionary[ [self percentKey] ] floatValue];
    
    return position;
}

#pragma mark - Keys

+ (NSString*) postAnimationColorKey
{
    return @"backgroundColor";
}

+ (NSString*) moveAnimationDurationKey
{
    return @"moveAnimationDuration";
}

+ (NSString*) alphaAnimationDurationKey
{
    return @"alphaAnimationDuration";
}

+ (NSString*) waitBeforeAnimationKey
{
    return @"waitingBefore";
}

+ (NSString*) durationKey
{
    return @"duration";
}

+ (NSString*) preAnimationPortraitPositionKey
{
    return @"preAnimationPositionPortrait";
}

+ (NSString*) postAnimationPortraitPosition
{
    return @"postAnimationPositionPortrait";
}

+ (NSString*) preAnimationLandscapePositionKey
{
    return @"preAnimationPositionLandscape";
}

+ (NSString*) postAnimationLandscapePosition
{
    return @"postAnimationPositionLandscape";
}

+ (NSString*) offsetXKey
{
    return @"offsetX";
}

+ (NSString*) offsetYKey
{
    return @"offsetY";
}

+ (NSString*) percentKey
{
    return @"percent";
}

#pragma mark - Init

- (id) initWithImageSize:(CGSize) imageSize portraitPosition:(CTWelcomeAnimationPosition*) portraitPosition landscapePosition:(CTWelcomeAnimationPosition*) landscapePosition;
{
    self = [super init];
    
    if ( self ) {
        
        _imageSize = imageSize;
        
        _portraitPosition = portraitPosition;
        _landscapePosition = landscapePosition;
        
        _waitingBeforeAnimation = 0.9f;
        _animationDuration = 1.5f;
        _waitingBeforeAlphaAnimation = 0.7f;
        _alphaAnimationDuration = 0.8;
    }
    
    return self;
}

#pragma mark - Public

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize isPortrait:(BOOL) isPortrait;
{
    
    CGRect rect = CGRectZero;
    rect.origin = [[self positionForIsPortrait:isPortrait] preAnimationOffset];
    rect.size = [self preAnimationImageSizeIsPortrait:isPortrait];
    
    return rect;
}

- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize isPortrait:(BOOL) isPortrait;
{
    CGRect rect = CGRectZero;
    rect.origin = [[self positionForIsPortrait:isPortrait] postAnimationOffset];
    rect.size = [self postAnimationImageSizeIsPortrait:isPortrait];
    
    return rect;
}

- (CGSize) preAnimationImageSizeIsPortrait:(BOOL) isPortrait;
{
    CGSize size = _imageSize;
    CGFloat percent = [[self positionForIsPortrait:isPortrait] preAnimationImagePercent];
    
    size.width *= percent;
    size.height *= percent;
    
    return size;
}

- (CGSize) postAnimationImageSizeIsPortrait:(BOOL) isPortrait;
{
    CGSize size = _imageSize;
    CGFloat percent = [[self positionForIsPortrait:isPortrait] postAnimationImagePercent];
    
    size.width *= percent;
    size.height *= percent;
    
    return size;
}

- (CTWelcomeAnimationPosition*) positionForIsPortrait:(BOOL) isPortrait
{
    return isPortrait ? _portraitPosition : _landscapePosition;
}

@end
