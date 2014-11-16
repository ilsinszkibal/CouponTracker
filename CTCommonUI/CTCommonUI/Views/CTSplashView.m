//
//  CTSplashView.m
//  CTCommonUI
//
//  Created by Teveli László on 10/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTSplashView.h"

@interface CTSplashView ()

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation CTSplashView

- (instancetype)initWithIconImage:(UIImage *)icon backgroundColor:(UIColor *)color
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.backgroundColor = color;
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iconImageView.tintColor = self.iconColor;
        iconImageView.frame = CGRectMake(0, 0, self.iconStartSize.width, self.iconStartSize.height);
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        iconImageView.center = self.center;
        
        [self addSubview:iconImageView];
        
        _iconImageView = iconImageView;
    }
    return self;
}

- (void)startAnimationWithCompletionHandler:(void (^)())completionHandler
{
    __block __weak typeof(self) weakSelf = self;
    
    if (!self.animationDuration) {
        return;
    }
    
    CGFloat shrinkDuration = self.animationDuration * 0.3;
    CGFloat growDuration = self.animationDuration * 0.7;
    
    [UIView animateWithDuration:shrinkDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
        weakSelf.iconImageView.transform = scaleTransform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:growDuration animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
            weakSelf.iconImageView.transform = scaleTransform;
            weakSelf.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            if (completionHandler) {
                completionHandler();
            }
        }];
    }];
}

@end
