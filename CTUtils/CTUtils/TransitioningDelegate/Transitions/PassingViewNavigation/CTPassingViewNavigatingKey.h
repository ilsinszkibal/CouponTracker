//
//  CTPassingViewNavigatingKey.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTPassingViewNavigatingKey : NSObject

@property (nonatomic, readonly) NSString* key;
@property (nonatomic, readonly) NSDictionary* parameters;

+ (instancetype) createNavigationWithKey:(NSString*) key;
+ (instancetype) createNavigationWithKey:(NSString*) key withParameters:(NSDictionary*) parameters;

@end
