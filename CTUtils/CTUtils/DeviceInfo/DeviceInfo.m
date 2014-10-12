//
//  DeviceInfo.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

+ (BOOL) isiPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (CGFloat) screenScale
{
    return [[UIScreen mainScreen] scale];
}

@end
