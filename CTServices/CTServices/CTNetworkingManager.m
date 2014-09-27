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
    [self addRequestDescriptor:self.cardRequestDescriptor];
    [self addResponseDescriptors:self.cardResponseDescriptors];
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
    //TODO
    return nil;
}

- (RKObjectMapping*)cardMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_PrintedCard class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"code"]];
    //[mapping addRelationshipMappingWithSourceKeyPath:@"template" mapping:self.templateMapping];
    return mapping;
}

- (NSArray*)cardResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"cards" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"card/:id" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)cardRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.cardMapping.inverseMapping objectClass:[Model_PrintedCard class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (RKObjectRequestOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion {
    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"cards" parameters:parameters];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion) completion(mappingResult.array, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion) completion(nil, error);
    }];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    return operation;
}

@end
