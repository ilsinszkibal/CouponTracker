//
//  CTColor.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTColor.h"

static UIColor* _viewControllerBackgroundColor;

@implementation CTColor

+ (UIColor*) viewControllerBackgroundColor
{
    if ( _viewControllerBackgroundColor == nil )
    {
        return [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.65];
    }
    
    return _viewControllerBackgroundColor;
}

+ (void) setViewControllerBackgroundColor:(UIColor*) color
{
    _viewControllerBackgroundColor = color;
}

+ (UIColor*) invalidColor
{
    return [UIColor colorWithRed:1 green:0.19 blue:0.24 alpha:1];
}

+ (UIColor*) validColor
{
    return [UIColor whiteColor];
}

+ (UIColor*) placeHolderGray
{
    return [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0];
}

@end
