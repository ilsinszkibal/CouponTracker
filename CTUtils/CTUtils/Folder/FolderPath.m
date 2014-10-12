//
//  FolderPath.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "FolderPath.h"

@implementation FolderPath

+ (NSString*) documentsFolderPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return documentsDirectory;
}

+ (NSString*) defaultBackgroundAnimationPath
{
    
    NSString* defaultBackground = [[NSBundle mainBundle] pathForResource:@"DefaultBackgroundiPad" ofType:@"json"];
    return defaultBackground;
}

@end
