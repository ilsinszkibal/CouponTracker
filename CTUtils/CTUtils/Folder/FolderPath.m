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

+ (NSString*) backgroundImagePath
{
    NSString* imagePath = [NSString stringWithFormat:@"%@/%@", [self documentsFolderPath], @"backgroundImage.jpg" ];
    return imagePath;
}

+ (NSString*) backgroundAnimationPath
{
    NSString* animationPath = [NSString stringWithFormat:@"%@/%@", [self documentsFolderPath], @"backgroundAnimation.json" ];
    return animationPath;
}

+ (BOOL) checkIfFileExists:(NSString*) path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL) setURLIsExcludedFromBackupKeyForFilePath:(NSString*) filePath
{
    
    NSString* documentsFolderPath = [self documentsFolderPath];
    NSRange documentsRange = [filePath rangeOfString:documentsFolderPath];
    
    if ( documentsRange.location != 0 )
    {
        //Not in the documents folder, then no point in saving the file
        return NO;
    }
    

    //Add NSURLIsExcludedFromBackupKey in order to not back up on icloud
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath] )
    {
        NSError* error = nil;
        BOOL success = [[NSURL fileURLWithPath:filePath] setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
        
        if ( success == NO )
        {
            NSLog(@"FolderPath setURLIsExcludedFromBackupKeyForFilePath failed for path %@ error %@", filePath, error);
        }
        
        //Return
        return error == nil;
    }
    
    return NO;
}

@end
