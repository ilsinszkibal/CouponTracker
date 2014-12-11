//
//  CTAnalytics.h
//  CTAnalytics
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAnalytics : NSObject

- (void)logEvent:(NSString*)eventName;
- (void)logScreenEvent:(NSString*)screenName;

@end
