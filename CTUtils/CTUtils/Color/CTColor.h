//
//  CTColor.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTColor : NSObject

+ (UIColor*) viewControllerBackgroundColor;

+ (UIColor*) invalidColor;
+ (UIColor*) validColor;

+ (UIColor*) placeHolderGray;

@end
