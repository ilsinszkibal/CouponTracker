//
//  CGExtensions.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CGExtensions.h"

CG_EXTERN CGPoint CGPointMultiply(CGPoint point, CGFloat value)
{
    CGPoint returnPoint = point;
    returnPoint.x *= value;
    returnPoint.y *= value;
    
    return returnPoint;
}

@implementation CGExtensions

@end
