//
//  FolderPath.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "FolderPath.h"

#import "DeviceInfo.h"

@implementation FolderPath

+ (NSString*) documentsFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+ (NSString*) defaultBackgroundImagePath
{
    NSString* defaultBackground = [[NSBundle mainBundle] pathForResource:@"DefaultBackground" ofType:@"jpg"];
    return defaultBackground;
}

+ (NSString*) defaultBackgroundAnimationPath
{
    
    NSString* deviceSpecific = [DeviceInfo isiPhone] ? @"DefaultBackgroundiPhone" : @"DefaultBackgroundiPad";
    
    NSString* defaultBackground = [[NSBundle mainBundle] pathForResource:deviceSpecific ofType:@"json"];
    return defaultBackground;
}

@end
