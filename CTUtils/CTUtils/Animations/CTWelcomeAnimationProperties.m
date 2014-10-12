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
    
    struct AnimationPosition prePosition = [self animationPosition:dictionary[ [self preAnimationPositionKey] ] ];
    struct AnimationPosition postPosition = [self animationPosition:dictionary[ [self postAnimationPosition] ] ];
    
    //Normalize because json is in pixels
    prePosition.offset = CGPointMultiply(prePosition.offset, 1.0f / [DeviceInfo screenScale] );
    postPosition.offset = CGPointMultiply(postPosition.offset, 1.0f / [DeviceInfo screenScale] );
    
    struct AnimationDuration movingAnimation = [self animationDuration:dictionary[ [self moveAnimationDurationKey] ] ];
    struct AnimationDuration alphaAnimation = [self animationDuration:dictionary[ [self alphaAnimationDurationKey] ] ];
    
    CTWelcomeAnimationProperties* animation = [[CTWelcomeAnimationProperties alloc] initWithImageSize:imageSize preOffset:prePosition.offset preImagePercent:prePosition.imagePercent postOffset:postPosition.offset postImagePercent:postPosition.imagePercent];
    
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

+ (NSString*) preAnimationPositionKey
{
    return @"preAnimationPosition";
}

+ (NSString*) postAnimationPosition
{
    return @"postAnimationPosition";
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

- (id) initWithImageSize:(CGSize) imageSize preOffset:(CGPoint) preOffset preImagePercent:(CGFloat) prePercent postOffset:(CGPoint) postOffset postImagePercent:(CGFloat) postPercent
{
    self = [super init];
    
    if ( self ) {
        
        _imageSize = imageSize;
        _preAnimationOffset = preOffset;
        _preAnimationImagePercent = prePercent;
        
        _postAnimationOffset = postOffset;
        _postAnimationImagePercent = postPercent;
        
        _waitingBeforeAnimation = 0.9f;
        _animationDuration = 1.5f;
        _waitingBeforeAlphaAnimation = 0.7f;
        _alphaAnimationDuration = 0.8;
    }
    
    return self;
}

#pragma mark - Public

- (CGRect) preWelcomeAnimationImageRect:(CGSize) windowSize
{
    CGRect rect = CGRectZero;
    rect.origin = _preAnimationOffset;
    rect.size = [self preAnimationImageSize];
    
    return rect;
}

- (CGRect) postWelcomeAnimationImageRect:(CGSize) windowSize
{
    CGRect rect = CGRectZero;
    rect.origin = _postAnimationOffset;
    rect.size = [self postAnimationImageSize];
    
    return rect;
}

- (CGSize) preAnimationImageSize
{
    CGSize size = _imageSize;
    
    size.width *= _preAnimationImagePercent;
    size.height *= _preAnimationImagePercent;
    
    return size;
}

- (CGSize) postAnimationImageSize
{
    CGSize size = _imageSize;
    
    size.width *= _postAnimationImagePercent;
    size.height *= _postAnimationImagePercent;
    
    return size;
}

@end
