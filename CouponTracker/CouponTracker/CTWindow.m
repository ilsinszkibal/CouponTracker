//
//  CTWindow.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTWindow.h"

#import "CTBackgroundService.h"
#import "CTColor.h"

@interface CTWindow () {
    
    UIImageView* _backgroundImageView;
    CGSize _backgroundImageViewSize;
    
    CTWelcomeAnimationProperties* _animationProperties;
    
    UIMotionEffectGroup* _motionEffects;
}

@end

@implementation CTWindow

- (id) initWithFrame:(CGRect)frame
{
   
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        NSString* imagePath = [[CTBackgroundService sharedManager] backgroundImagePath];
//        UIImage* image = [UIImage imageNamed:imageName];
        UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:image ];
        
        CGSize backgroundImageViewSize = _backgroundImageView.image.size;
        _animationProperties = [[CTBackgroundService sharedManager] welcomeAnimationPropertiesForImageSize:backgroundImageViewSize];
        
        [CTColor setViewControllerBackgroundColor:[_animationProperties postAnimationColor] ];
        
        [[CTBackgroundService sharedManager] checkForUpdate];
        
        [self addSubview:_backgroundImageView];
    }
    
    return self;
}

#pragma mark - LayoutSubviews

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if ( [_animationProperties isAnimating] == NO )
    {
        [self setBackgroundImagePosition];
    }
}

#pragma mark - Private

- (void) setUpMotionEffects
{
    
    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-20);
    verticalMotionEffect.maximumRelativeValue = @(20);
    
    UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-20);
    horizontalMotionEffect.maximumRelativeValue = @(20);
    
    _motionEffects = [UIMotionEffectGroup new];
    _motionEffects.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    [_backgroundImageView addMotionEffect:_motionEffects];
    
}

- (void) setBackgroundImagePosition
{
    [_backgroundImageView setFrame:[_animationProperties postWelcomeAnimationImageRect:self.bounds.size] ];
}

#pragma mark - Public

- (void) timerRepresentBack:(NSTimer*) timer
{
    [UIView animateWithDuration:[_animationProperties alphaAnimationDuration] animations:^{
        [self.rootViewController.view setAlpha:1.0f];
    }];
}

- (void) presentAnimation
{
    
    [NSTimer scheduledTimerWithTimeInterval:[_animationProperties waitingBeforeAlphaAnimation] target:self selector:@selector(timerRepresentBack:) userInfo:self repeats:NO];
    
    [UIView animateWithDuration:[_animationProperties animationDuration] animations:^{
        [self setBackgroundImagePosition];
    } completion:^(BOOL finished) {
        [self completedAnimation:finished];
    }];
    
}

- (void) completedAnimation:(BOOL) finished
{
    [self setUpMotionEffects];
}

- (void) welcomeAnimation
{
    
    [_animationProperties setIsAnimating:YES];
    
    [self.rootViewController.view setAlpha:0.0f];
    
    [_backgroundImageView setFrame:[_animationProperties preWelcomeAnimationImageRect:self.bounds.size] ];
    
    [NSTimer scheduledTimerWithTimeInterval:[_animationProperties waitingBeforeAnimation] target:self selector:@selector(presentAnimation) userInfo:nil repeats:NO];
    
    
//    [UIView animateWithDuration:animationDuration animations:^{
//        [self setBackgroundImagePosition];
//    } completion:^(BOOL finished) {
//    }];

}

@end
