//
//  BackgroundService.m
//  CTServices
//
//  Created by Balazs Ilsinszki on 12/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBackgroundService.h"

#import "FolderPath.h"

#import "CTNetworkingManager.h"

@interface CTBackgroundService () {
    
    NSString* _jsonPath;
    NSString* _imagePath;
    
}

@end

@implementation CTBackgroundService

#pragma mark - Init

- (id) init
{
    self = [super init];
    
    if ( self ) {
        [self setUpAnimationPath];
    }
    
    return self;
}

- (void) setUpAnimationPath
{
    NSString* jsonPath = [FolderPath backgroundAnimationPath];
    NSString* imagePath = [FolderPath backgroundImagePath];
    
    if ( [FolderPath checkIfFileExists:jsonPath] && [FolderPath checkIfFileExists:imagePath] )
    {
        _jsonPath = jsonPath;
        _imagePath = imagePath;
    }
    else
    {
        _jsonPath = [FolderPath defaultBackgroundAnimationPath];
        _imagePath = [FolderPath defaultBackgroundImagePath];
    }
    
    
}

#pragma mark - Public

- (NSString*) backgroundImagePath
{
    return _imagePath;
}

- (CTWelcomeAnimationProperties*) welcomeAnimationPropertiesForImageSize:(CGSize) imageSize
{
    NSDictionary* dictionary = [self animationDictForPath:_jsonPath];
    return [CTWelcomeAnimationProperties createOpeningAnimationForImageSize:imageSize withDictionary:dictionary];
}

- (void) checkForUpdate
{
    
    long currentBackgroundTime = [self currentBackgroundTime];
    
    [[CTNetworkingManager sharedManager] getSettingsID:^(CTServerSettings *settingsID, NSError *error) {
        
        if ( currentBackgroundTime < [[settingsID backgroundAnimationSettingsID] longValue] )
        {
            [self performUpdate];
        }
        
    }];
    
}

#pragma mark - Updating process

- (void) performUpdate
{
    NSLog(@"Perform update");
    
    [[CTNetworkingManager sharedManager] getBackgroundAnimationJSON:^(NSDictionary *settingsID, NSError *error) {
        NSLog(@"BackgroundAnim");
    }];
    
}

- (long) currentBackgroundTime
{
    NSDictionary* animationDict = [self animationDictForPath:_jsonPath];
    
    long result = [animationDict[ [CTBackgroundService timeKey] ] longValue];
    return result;
}

-(NSDictionary*) animationDictForPath:(NSString*) path
{
    if ( [FolderPath checkIfFileExists:path] == NO )
        return nil;
    
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path];
    NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    return dictionary;
}

#pragma mark - Keys

+(NSString*) timeKey
{
    return @"epochtime";
}

@end
