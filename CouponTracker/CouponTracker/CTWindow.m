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
}

@end

@implementation CTWindow

- (id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        NSString* imageName = [[CTBackgroundService sharedManager] backgroundImagePath];
        UIImage* image = [UIImage imageNamed:imageName];
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:image ];
        
        CGSize backgroundImageViewSize = _backgroundImageView.image.size;
        _animationProperties = [[CTBackgroundService sharedManager] welcomeAnimationPropertiesForImageSize:backgroundImageViewSize];
        
        [CTColor setViewControllerBackgroundColor:[_animationProperties postAnimationColor] ];
        
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
    }];
    
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
