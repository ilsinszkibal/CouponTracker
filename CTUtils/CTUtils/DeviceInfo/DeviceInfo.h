//
//  DeviceInfo.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfo : NSObject

+ (BOOL) isiPhone;
+ (BOOL) isPortrait;

+(BOOL) isSmallerThanPhone6Form;
+(BOOL) isSmallerThanPhone6PlusForm;

+ (CGFloat) screenScale;
+ (CGSize) screenSize;

@end
