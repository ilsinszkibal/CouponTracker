//
//  CTNetworkingManager.m
//  CTServices
//
//  Created by Teveli László on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNetworkingManager.h"

#import "Model.h"
#import "DeviceInfo.h"

#import <RestKit/RestKit.h>

@implementation CTNetworkingManager

- (void)setUp {
    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://www.coupontracker.org/api/v1/"]];
    [RKObjectManager setSharedManager:manager];
    
    RKLogSetAppLoggingLevel(RKLogLevelInfo);
    
    [self addRequestDescriptor:self.cardRequestDescriptor];
    [self addResponseDescriptors:self.cardResponseDescriptors];

    [self addRequestDescriptor:self.readRequestDescriptor];
    [self addResponseDescriptors:self.readResponseDescriptors];
    
    [self addRequestDescriptor:self.imageRequestDescriptor];
    [self addResponseDescriptors:self.imageResponseDescriptors];
    
    [self addRequestDescriptor:self.templateRequestDescriptor];
    [self addResponseDescriptors:self.templateResponseDescriptors];
    
    [self addResponseDescriptors:[self settingsIDResponseDescriptors]];
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

#pragma mark - Image

- (RKObjectMapping*)imageMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_Image class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name", @"url"]];
    return mapping;
}

- (NSArray*)imageResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"images.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"images/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)imageRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.cardMapping.inverseMapping objectClass:[Model_Image class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}


- (NSOperation*)postImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion {
    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    NSDictionary* imageDictionary = @{@"name": @"uploaded image", @"file": [imageData base64EncodedStringWithOptions:0]};
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:imageDictionary method:RKRequestMethodPOST path:@"images.json" parameters:@{}];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion) completion(mappingResult.array.lastObject, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion) completion(nil, error);
    }];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    return operation;
}

#pragma mark - Card

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

#pragma mark - Read

- (RKObjectMapping*)readMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_PrintedCard class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"code", @"latitude", @"longitude"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"card" mapping:self.cardMapping];
    return mapping;
}

- (NSArray*)readResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.readMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"reads.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"reads/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)readRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.readMapping.inverseMapping objectClass:[Model_PrintedCard class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (NSOperation*)readCardWithCode:(NSString*)code completion:(void(^)(Model_CardRead* read, NSError* error))completion {
    Model_CardRead* read = [[Model_CardRead alloc] init];
    [read setCode:code];
    //TODO: set latitude, longitude
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:read method:RKRequestMethodPOST path:@"reads.json" parameters:@{}];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion)
        {
            completion(mappingResult.array.lastObject, nil);
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

//- (void)getCardForCode:(NSString*)code completion:(void(^)(Model_PrintedCard* card, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_PrintedCard class]];
//    [self _GETForPath:path parameters:@{@"filter": [NSString stringWithFormat:@"code:%@", code], @"limit": @"1", @"fields": @"all"} completionBlock:^(RKMappingResult *result, NSError *error) {
//        Model_PrintedCard* card = (Model_PrintedCard*)result.array.lastObject;
//        if (completion) {
//            completion(card, error);
//        }
//    }];
//}

#pragma mark - Template

- (RKObjectMapping*)templateMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardTemplate class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name"]];
//    [mapping addRelationshipMappingWithSourceKeyPath:@"type" mapping:self.typeMapping];
    return mapping;
}

- (NSArray*)templateResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.templateMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"templates.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.cardMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"templates/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)templateRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.templateMapping.inverseMapping objectClass:[Model_PrintedCard class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}


- (NSOperation*)getMyTemplates:(void(^)(NSArray* templates, NSError* error))completion {
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"templates.json" parameters:@{@"filter": @"user:me"}];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion) {
            completion(mappingResult.array, nil);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

- (NSOperation*)getPopularTemplates:(void(^)(NSArray* templates, NSError* error))completion {
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"templates.json" parameters:@{@"sort": @"popular"}];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion) {
            completion(mappingResult.array, nil);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

#pragma mark - Settings

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
    
    CGFloat screenScale = [DeviceInfo screenScale];
    CGSize screenSize = [DeviceInfo screenSize];
    NSDictionary* parameters = @{ @"screenWidth" : @(screenSize.width), @"screenHeight" : @(screenSize.height), @"screenScale" : @(screenScale) };
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"settingsID.json" parameters:parameters];
    
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
    [mapping addAttributeMappingsFromArray:@[@"epochtime", @"imageName", @"preAnimationPosition", @"postAnimationPosition", @"moveAnimationDuration", @"alphaAnimationDuration", @"backgroundColor"]];
    return mapping;
}

- (NSArray*) backgroundAnimationResponseDescriptors
{
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self backgroundAnimationMapping] method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"backgroundAnimation.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return @[ responseDescriptor ];
}

- (NSOperation*)getBackgroundAnimationJSON:(void(^)(NSDictionary* settingsID, NSError* error))completion
{
    
    CGFloat screenScale = [DeviceInfo screenScale];
    CGSize screenSize = [DeviceInfo screenSize];
    NSDictionary* parameters = @{ @"screenWidth" : @(screenSize.width), @"screenHeight" : @(screenSize.height), @"screenScale" : @(screenScale) };
    
    RKObjectRequestOperation* operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:@"backgroundAnimation.json" parameters:parameters];

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if ( completion )
            completion([mappingResult firstObject], nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if ( completion )
            completion(nil, error);
    }];

    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

@end
