//
//  BaseManager.h
//  SplashApp
//
//  Created by Teveli László on 20/12/13.
//  Copyright (c) 2013 László Teveli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTBaseManager : NSObject

@property (assign, readonly) BOOL isInitialized;

+ (instancetype)sharedManager;

- (void)setUp;

@end
