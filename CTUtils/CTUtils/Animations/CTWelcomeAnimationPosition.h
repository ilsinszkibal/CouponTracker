//
//  CTWelcomeAnimationPosition.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 09/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTWelcomeAnimationPosition : NSObject

@property (nonatomic, readonly) CGPoint preAnimationOffset;
@property (nonatomic, readonly) CGFloat preAnimationImagePercent;

@property (nonatomic, readonly) CGPoint postAnimationOffset;
@property (nonatomic, readonly) CGFloat postAnimationImagePercent;

+ (CTWelcomeAnimationPosition*) positionWithPreOffset:(CGPoint) preOffset withPrePercent:(CGFloat) prePercent withPostOffset:(CGPoint) postOffset withPostPercent:(CGFloat) postPercent;

@end
