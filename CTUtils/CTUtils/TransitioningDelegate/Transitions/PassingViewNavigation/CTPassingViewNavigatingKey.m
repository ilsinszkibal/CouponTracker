//
//  CTPassingViewNavigatingKey.m
//  CTUtils
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPassingViewNavigatingKey.h"

@interface CTPassingViewNavigatingKey ()

@property (nonatomic, strong) NSString* key;
@property (nonatomic, strong) NSDictionary* parameters;

@end

@implementation CTPassingViewNavigatingKey

+ (instancetype) createNavigationWithKey:(NSString*) key
{
    return [self createNavigationWithKey:key withParameters:nil];
}

+ (instancetype) createNavigationWithKey:(NSString*) key withParameters:(NSDictionary*) parameters
{
    
    if ( [key length] == 0 )
        return nil;
    
    CTPassingViewNavigatingKey* navigatingKey = [[CTPassingViewNavigatingKey alloc] init];
    navigatingKey.key = key;
    navigatingKey.parameters = parameters;
    
    return navigatingKey;
}

@end
