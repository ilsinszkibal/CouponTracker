//
//  CTNetworkingManager.h
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"
#import <RestKit.h>

@interface CTNetworkingManager : CTBaseManager

- (RKObjectRequestOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion;

@end
