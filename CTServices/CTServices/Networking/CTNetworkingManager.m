//
//  CTNetworkingManager.m
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNetworkingManager.h"

#import "Model.h"

#import <RestKit.h>

@implementation CTNetworkingManager

- (void)setUp {
    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://www.coupontracker.org/api/v1/"]];
    [RKObjectManager setSharedManager:manager];
    
    RKLogSetAppLoggingLevel(RKLogLevelInfo);
    
    [self addRequestDescriptor:self.cardRequestDescriptor];
    [self addResponseDescriptors:self.cardResponseDescriptors];
    
    [self addResponseDescriptors:[self settingsIDResponseDescriptors] ];
    
    [self addResponseDescriptors:[self backgroundAnimationResponseDescriptors] ];
}

- (void)addRequestDescriptor:(RKRequestDescriptor*)descriptor {
    BOOL allowed = YES;
    for (RKRequestDescriptor* requestDescriptor in [RKObjectManager sharedManager].requestDescriptors) {
        if (requestDescriptor.objectClass == descriptor.objectClass) {
            allowed = NO;
            break;
        }
    }
    if (descriptor && allowed) {
        [[RKObjectManager sharedManager] addRequestDescriptor:descriptor];
    }
}

- (void)addResponseDescriptor:(RKResponseDescriptor*)descriptor {
    [[RKObjectManager sharedManager] addResponseDescriptor:descriptor];
}

- (void)addResponseDescriptors:(NSArray*)descriptors {
    for (RKResponseDescriptor* descriptor in descriptors) {
        [self addResponseDescriptor:descriptor];
    }
}

- (RKObjectMapping*)templateMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardTemplate class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name"]];
//    [mapping addRelationshipMappingWithSourceKeyPath:@"type" mapping:self.typeMapping];
    return mapping;
}

- (RKObjectMapping*)cardMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_PrintedCard class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"code"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"template" mapping:self.templateMapping];
    return mapping;
}

- (NSArray*)cardResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"cards.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"cards/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)cardRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.cardMapping.inverseMapping objectClass:[Model_PrintedCard class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (RKObjectRequestOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion {
    
    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"cards.json" parameters:parameters];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion)
        {
            completion(mappingResult.array, nil);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion)
        {
            completion(nil, error);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

#pragma mark - Settigns

- (RKObjectMapping*)settingsIDMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[CTServerSettings class]];
    [mapping addAttributeMappingsFromArray:@[@"backgroundAnimationSettingsID" ] ];
    return mapping;
}

- (NSArray*)settingsIDResponseDescriptors
{
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self settingsIDMapping] method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"settingsID.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return @[ responseDescriptor ];
}

- (NSOperation*)getSettingsID:(void(^)(CTServerSettings* settingsID, NSError* error))completion
{
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"settingsID.json" parameters:nil];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ( completion )
        {
            completion( [mappingResult firstObject], nil );
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if ( completion )
        {
            completion( nil, error );
        }
    }];
    
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

#pragma mark - Background animation settings

- (RKObjectMapping*) backgroundAnimationMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [mapping addAttributeMappingsFromArray:@[@"epochtime"]];
    return mapping;
}

- (NSArray*) backgroundAnimationResponseDescriptors
{
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self backgroundAnimationMapping] method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"backgroundAnimation.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return @[ responseDescriptor ];
}

- (NSOperation*)getBackgroundAnimationJSON:(void(^)(NSDictionary* settingsID, NSError* error))completion
{
    RKObjectRequestOperation* operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"backgroundAnimation.json" parameters:nil];

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Succ %@", [mappingResult firstObject] );
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
    }];

    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

@end
