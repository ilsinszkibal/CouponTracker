//
//  CTWelcomeAnimationPosition.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 09/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTWelcomeAnimationPosition.h"

@interface CTWelcomeAnimationPosition ()

@property (nonatomic, assign) CGPoint preAnimationOffset;
@property (nonatomic, assign) CGFloat preAnimationImagePercent;

@property (nonatomic, assign) CGPoint postAnimationOffset;
@property (nonatomic, assign) CGFloat postAnimationImagePercent;

@end

@implementation CTWelcomeAnimationPosition

+ (CTWelcomeAnimationPosition*) positionWithPreOffset:(CGPoint) preOffset withPrePercent:(CGFloat) prePercent withPostOffset:(CGPoint) postOffset withPostPercent:(CGFloat) postPercent
{
    CTWelcomeAnimationPosition* animationPosition = [[CTWelcomeAnimationPosition alloc] init];
    
    [animationPosition setPreAnimationOffset:preOffset];
    [animationPosition setPreAnimationImagePercent:prePercent];
    
    [animationPosition setPostAnimationOffset:postOffset];
    [animationPosition setPostAnimationImagePercent:postPercent];
    
    return animationPosition;
}

@end
