//
//  FolderPath.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FolderPath : NSObject

+ (NSString*) documentsFolderPath;

//BackgroundAnimation
+ (NSString*) defaultBackgroundImagePath;
+ (NSString*) defaultBackgroundAnimationPath;

+ (NSString*) backgroundImagePath;
+ (NSString*) backgroundAnimationPath;

//Checked
+ (BOOL) checkIfFileExists:(NSString*) path;

@end
