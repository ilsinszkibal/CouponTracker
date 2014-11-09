//
//  CTLocationManager.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 09/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTLocationManager.h"

#import "FolderPath.h"

@interface CTLocationManager ()

@property (nonatomic, strong) INTULocationManager* locationManager;

@property (nonatomic, strong) CLLocation* lastLocation;

@end

@implementation CTLocationManager

static CTLocationManager* _sharedInstance;

+ (instancetype)sharedInstance
{
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _sharedInstance = [[CTLocationManager alloc] init];
    });
    return _sharedInstance;
}

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        _locationManager = [INTULocationManager sharedInstance];
    }
    
    return self;
}

#pragma mark - Save location

- (void) saveLastLocation:(CLLocation*) location
{
    
    _lastLocation = location;
    
    if ( _lastLocation != nil )
    {
        
        NSString* lastLocationPath = [FolderPath lastLocationPath];
    
        NSNumber* latitudeNumber = [NSNumber numberWithDouble:_lastLocation.coordinate.latitude];
        NSNumber* longitudeNumber = [NSNumber numberWithDouble:_lastLocation.coordinate.longitude];
        
        //Save location dictionary
        NSDictionary* locationDictionary = @{ [self latitudeKey] : latitudeNumber, [self longitudeKey] : longitudeNumber };
        [locationDictionary writeToFile:lastLocationPath atomically:YES];
        
        //Set data stroage flag
        [FolderPath setURLIsExcludedFromBackupKeyForFilePath:lastLocationPath];
        
    }
    
}

- (CLLocation*) savedLocation
{
    
    CLLocation* savedLocation = nil;
    NSString* lastLocationPath = [FolderPath lastLocationPath];
    
    if ( [FolderPath checkIfFileExists:lastLocationPath] )
    {
        NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:lastLocationPath];
        
        NSNumber* latitudeNumber = dictionary[ [self latitudeKey] ];
        NSNumber* longitudeNumber = dictionary[ [self longitudeKey] ];
        
        if ( latitudeNumber && longitudeNumber )
        {
            savedLocation = [[CLLocation alloc] initWithLatitude:[latitudeNumber doubleValue] longitude:[longitudeNumber doubleValue] ];
        }
        
    }
    
    return savedLocation;
}

- (NSString*) latitudeKey
{
    return @"latitudeKey";
}

- (NSString*) longitudeKey
{
    return @"longitudeKey";
}

#pragma mark - Public properties

- (BOOL) locationServicesAvailable
{
    return [_locationManager locationServicesAvailable];
}

- (CLLocation*) lastLocation
{
    if ( _lastLocation )
    {
        return _lastLocation;
    }
    
    return [self savedLocation];
}

#pragma mark - Public requests

- (NSInteger)requestLocationWithDesiredAccuracy:(INTULocationAccuracy)desiredAccuracy
                                        timeout:(NSTimeInterval)timeout
                                          block:(INTULocationRequestBlock)block
{
    
    NSInteger retValue = [_locationManager requestLocationWithDesiredAccuracy:desiredAccuracy timeout:timeout block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        //Save as last location
        if ( status == INTULocationStatusSuccess )
        {
            [self saveLastLocation:currentLocation];
        }
    
        
        if ( block )
        {
            block( currentLocation, achievedAccuracy, status );
        }
        
    }];
    
    return retValue;
}

- (NSInteger)requestLocationWithDesiredAccuracy:(INTULocationAccuracy)desiredAccuracy
                                        timeout:(NSTimeInterval)timeout
                           delayUntilAuthorized:(BOOL)delayUntilAuthorized
                                          block:(INTULocationRequestBlock)block
{
    
    NSInteger retValue = [_locationManager requestLocationWithDesiredAccuracy:desiredAccuracy timeout:timeout delayUntilAuthorized:delayUntilAuthorized block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        //Save as last location
        if ( status == INTULocationStatusSuccess )
        {
            [self saveLastLocation:currentLocation];
        }
        
        if ( block )
        {
            block( currentLocation, achievedAccuracy, status );
        }
        
    }];
    
    return retValue;
}

- (void)forceCompleteLocationRequest:(NSInteger)requestID
{
    [_locationManager forceCompleteLocationRequest:requestID];
}

- (void)cancelLocationRequest:(NSInteger)requestID
{
    [_locationManager cancelLocationRequest:requestID];
}

@end
