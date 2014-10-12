//
//  BackgroundService.m
//  CTServices
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBackgroundService.h"

#import "FolderPath.h"

@implementation CTBackgroundService

- (id) init
{
    self = [super init];
    
    if ( self ) {
        
    }
    
    return self;
}

- (NSString*) backgroundImagePath
{
    return [FolderPath defaultBackgroundImagePath];
}

- (CTWelcomeAnimationProperties*) welcomeAnimationPropertiesForImageSize:(CGSize) imageSize
{
    
    NSString* defaultAnimationPath = [FolderPath defaultBackgroundAnimationPath];
    
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:defaultAnimationPath ];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    return [CTWelcomeAnimationProperties createOpeningAnimationForImageSize:imageSize withDictionary:dictionary];
}

- (void) checkForUpdate
{
    
}

@end
