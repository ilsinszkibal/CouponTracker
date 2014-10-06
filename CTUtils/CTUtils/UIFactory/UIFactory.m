//
//  UIFactory.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (UIButton*) defaultButtonWithTitle:(NSString*) title target:(id) target action:(SEL) selector
{
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    if ( title )
    {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if ( target )
    {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

@end
