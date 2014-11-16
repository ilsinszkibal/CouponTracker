//
//  DeviceInfo.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "DeviceInfo.h"

typedef NS_ENUM(NSInteger, SizeCompare)
{
    SizeCompareNotEqual = 0,
    SizeCompareSame,
    SizeCompareBothBigger,
    SizeCompareBothSmaller
};

@implementation DeviceInfo

+ (BOOL) isiPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL) isPortrait
{
    return UIInterfaceOrientationIsPortrait( [[UIApplication sharedApplication] statusBarOrientation] );
}

#pragma mark - ScreenSize

+(BOOL) isSmallerThanPhone6Form
{
    SizeCompare compare = [self compareScreenSizeToMaxSize:667 toMinSize:375];
    return compare == SizeCompareBothBigger;
}

+(BOOL) isSmallerThanPhone6PlusForm
{
    SizeCompare compare = [self compareScreenSizeToMaxSize:736 toMinSize:414];
    
    return compare == SizeCompareBothBigger;
}

+(SizeCompare) compareScreenSizeToMaxSize:(CGFloat) maxSize toMinSize:(CGFloat) minSize
{
    CGSize size = [self screenSize];
    
    CGFloat maxDimension = MAX(size.width, size.height);
    CGFloat minDimension = MIN(size.width, size.height);
    
    if ( maxDimension == maxSize && minDimension == minSize )
    {
        return SizeCompareSame;
    }
    else if ( maxDimension < maxSize && minDimension < minSize )
    {
        return SizeCompareBothBigger;
    }
    else if ( maxDimension > maxSize && minDimension > minSize )
    {
        return SizeCompareBothSmaller;
    }
    
    return SizeCompareNotEqual;
}

#pragma mark - Properties

+ (CGFloat) screenScale
{
    return [[UIScreen mainScreen] scale];
}

+ (CGSize) screenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

@end
