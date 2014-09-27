//
//  BaseManager.m
//  SplashApp
//
//  Created by Teveli László on 20/12/13.
//  Copyright (c) 2013 László Teveli. All rights reserved.
//

#import "CTBaseManager.h"

static NSMutableDictionary *_sharedInstances = nil;

@implementation CTBaseManager

+ (void)initialize
{
    if (_sharedInstances == nil) {
        _sharedInstances = [NSMutableDictionary dictionary];
    }
}

+ (id)allocWithZone:(NSZone *)zone
{
    // Not allow allocating memory in a different zone
    return [self sharedManager];
}

+ (id)copyWithZone:(NSZone *)zone
{
    // Not allow copying to a different zone
    return [self sharedManager];
}

#pragma mark -

+ (instancetype)sharedManager
{
    id sharedInstance = nil;
    
    @synchronized(self) {
        NSString *instanceClass = NSStringFromClass(self);
        
        // Looking for existing instance
        sharedInstance = [_sharedInstances objectForKey:instanceClass];
        
        // If there's no instance – create one and add it to the dictionary
        if (sharedInstance == nil) {
            sharedInstance = [[super allocWithZone:nil] init];
            [sharedInstance setUp];
            [_sharedInstances setObject:sharedInstance forKey:instanceClass];
        }
    }
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self && !self.isInitialized) {
        // Thread-safe because it called from +sharedInstance
        _isInitialized = YES;
    }
    
    return self;
}

- (void)setUp {
    
}

@end
