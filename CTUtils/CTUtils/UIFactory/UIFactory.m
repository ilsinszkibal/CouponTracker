//
//  UIFactory.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "UIFactory.h"

#import "DeviceInfo.h"

@implementation UIFactory

#pragma mark - Button

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
    
    [self setBordersAndCornerToButton:button];
    
    return button;
}

+ (void) setBordersAndCornerToButton:(UIView*) view
{
    [view.layer setCornerRadius:5];
    [view.layer setBorderColor:[UIColor whiteColor].CGColor ];
    [view.layer setBorderWidth:1];
}

+ (UIImage*) imageWhiteNamed:(NSString*) name
{
    UIImage* image = [UIImage imageNamed:name];
    return [self image:image withColor:[UIColor whiteColor] ];
}

+ (UIImage*) image:(UIImage*) image withColor:(UIColor*) color
{
    CGSize imageSize = image.size;
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [DeviceInfo screenScale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor );
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    
    CGRect rect = CGRectZero;
    rect.size = imageSize;
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage* tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
