//
//  UIView+UIView_Frame.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 09/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "UIView+UIView_Frame.h"

@implementation UIView (UIView_Frame)

- (CGFloat) x
{
    return self.frame.origin.x;
}

- (CGFloat) y
{
    return self.frame.origin.y;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (CGFloat) height
{
    return self.frame.size.height;
}

- (CGFloat) maxX
{
    return [self x] + [self width];
}

- (CGFloat) maxY
{
    return [self y] + [self height];
}

@end
