//
//  BackgroundService.h
//  CTServices
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTWelcomeAnimationProperties.h"
#import "CTBaseManager.h"

@interface CTBackgroundService : CTBaseManager

- (NSString*) backgroundImagePath;
- (CTWelcomeAnimationProperties*) welcomeAnimationPropertiesForImageSize:(CGSize) imageSize;

- (void) checkForUpdate;

@end
