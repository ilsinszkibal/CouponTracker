//
//  UIFactory.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFactory : NSObject

+ (UIButton*) defaultButtonWithTitle:(NSString*) title target:(id) target action:(SEL) selector;
+ (void) setBordersAndCornerToButton:(UIView*) view;

@end
