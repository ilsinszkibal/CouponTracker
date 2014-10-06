//
//  CTColor.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTColor.h"

@implementation CTColor

+ (UIColor*) viewControllerBackgroundColor
{
    return [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:0.65];
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
