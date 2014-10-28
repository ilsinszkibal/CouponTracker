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
#import "CTUser.h"

#import <RestKit/RestKit.h>
#import <INTULocationManager.h>

@interface RKObjectRequestOperation (progress)

- (void)setUploadStart:(void(^)(long long total))start progress:(void(^)(long long complete, long long total))progress completion:(void(^)())completion;
- (void)setDownloadStart:(void(^)(long long total))start progress:(void(^)(long long complete, long long total))progress completion:(void(^)())completion;

@end

@implementation RKObjectRequestOperation (progress)

- (void)setUploadStart:(void(^)(long long total))start progress:(void(^)(long long complete, long long total))progress completion:(void(^)())completion {
    [self.HTTPRequestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        double percentDone = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        if (percentDone == 0) {
            if (start) start(totalBytesExpectedToWrite);
        } else if (percentDone == 1) {
            if (completion) completion();
        } else {
            if (progress) progress(totalBytesWritten, totalBytesExpectedToWrite);
        }
    }];
}

- (void)setDownloadStart:(void(^)(long long total))start progress:(void(^)(long long complete, long long total))progress completion:(void(^)())completion {
    [self.HTTPRequestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        double percentDone = (double)totalBytesRead / (double)totalBytesExpectedToRead;
        if (percentDone == 0) {
            if (start) start(totalBytesExpectedToRead);
        } else if (percentDone == 1) {
            if (completion) completion();
        } else {
            if (progress) progress(totalBytesRead, totalBytesExpectedToRead);
        }
    }];
}

@end

@implementation CTNetworkingManager

- (void)setUp {
    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://www.coupontracker.org/api/v1/"]];
    [manager setRequestSerializationMIMEType:@"application/json"];
    [RKObjectManager setSharedManager:manager];
    
    RKLogSetAppLoggingLevel(RKLogLevelInfo);
    
    [self addRequestDescriptor:self.cardRequestDescriptor];
    [self addResponseDescriptors:self.cardResponseDescriptors];

    [self addRequestDescriptor:self.contentRequestDescriptor];
    [self addResponseDescriptors:self.contentResponseDescriptors];

    [self addRequestDescriptor:self.readRequestDescriptor];
    [self addResponseDescriptors:self.readResponseDescriptors];
    
    [self addRequestDescriptors:self.imageRequestDescriptors];
    [self addResponseDescriptors:self.imageResponseDescriptors];
    
    [self addRequestDescriptor:self.templateRequestDescriptor];
    [self addResponseDescriptors:self.templateResponseDescriptors];
    
    [self addRequestDescriptor:self.typeRequestDescriptor];
    [self addResponseDescriptors:self.typeResponseDescriptors];
    
    [self addRequestDescriptor:self.userRequestDescriptor];
    [self addResponseDescriptors:self.userResponseDescriptors];
    
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

- (void)addRequestDescriptors:(NSArray*)descriptors {
    for (RKRequestDescriptor* descriptor in descriptors) {
        [self addRequestDescriptor:descriptor];
    }
}

- (RKObjectRequestOperation*)requestPath:(NSString*)path method:(RKRequestMethod)method object:(id)object parameters:(NSDictionary*)parameters completion:(void(^)(NSArray* results, NSError* error))completionBlock {
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:object method:method path:path parameters:parameters];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSString* redirectUrl = operation.HTTPRequestOperation.response.allHeaderFields[@"Location"];
        if (operation.HTTPRequestOperation.response.statusCode == 201 && redirectUrl.length > 0) {
            NSString* redirectPath = [redirectUrl stringByReplacingOccurrencesOfString:[RKObjectManager sharedManager].baseURL.absoluteString withString:@""];
            [self requestPath:redirectPath method:RKRequestMethodGET object:nil parameters:parameters completion:completionBlock];
        } else {
            if (completionBlock) {
                completionBlock(mappingResult.array, nil);
            }
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

#pragma mark - Image

- (RKObjectMapping*)imageMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_Image class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name", @"url"]];
    return mapping;
}

- (NSArray*)imageResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.imageMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"images.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.imageMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"images/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (NSArray*)imageRequestDescriptors {
    RKObjectMapping* mapping1 = [RKObjectMapping requestMapping];
    [mapping1 addAttributeMappingsFromArray:@[@"name", @"file"]];
    RKRequestDescriptor* descriptor1 = [RKRequestDescriptor requestDescriptorWithMapping:mapping1 objectClass:[NSDictionary class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
    
    RKObjectMapping* mapping2 = [RKObjectMapping requestMapping];
    [mapping2 addAttributeMappingsFromArray:@[@"id"]];
    RKRequestDescriptor* descriptor2 =  [RKRequestDescriptor requestDescriptorWithMapping:mapping2 objectClass:[Model_Image class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
    
    return @[descriptor1, descriptor2];
}

- (NSOperation*)getImageWithId:(NSString*)imageId completion:(void(^)(Model_Image* image, NSError* error))completion {
    return [self requestPath:[NSString stringWithFormat:@"images/%@.json", imageId] method:RKRequestMethodGET object:nil parameters:@{} completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.lastObject, error);
    }];
}

- (NSOperation*)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion {
    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
    NSDictionary* imageDictionary = @{@"name": @"uploaded image", @"file": [imageData base64EncodedStringWithOptions:0]};
    
    return [self requestPath:@"images.json" method:RKRequestMethodPOST object:imageDictionary parameters:@{} completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.lastObject, error);
    }];
}

#pragma mark - Content

- (RKObjectMapping*)contentMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardContent class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"text", @"images", @"videos", @"urls"]];
    [mapping addAttributeMappingsFromDictionary:@{@"latitude": @"locationLatitude",
                                                  @"longitude": @"locationLongitude"}];
    //[mapping addRelationshipMappingWithSourceKeyPath:@"card" mapping:self.cardMapping];//causes reference loop
    [mapping addRelationshipMappingWithSourceKeyPath:@"owner" mapping:self.userMapping];
    return mapping;
}

- (NSArray*)contentResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.contentMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"contents.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.contentMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"contents/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)contentRequestDescriptor {
    RKObjectMapping* mapping = [RKObjectMapping requestMapping];
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[Model_CardContent class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
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
    RKObjectMapping* mapping = [RKObjectMapping requestMapping];
    RKObjectMapping* templateMapping = [RKObjectMapping requestMapping];
    [templateMapping addAttributeMappingsFromArray:@[@"id"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"template" mapping:templateMapping];
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[Model_PrintedCard class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (RKObjectRequestOperation*)getCards:(void(^)(NSArray* cards, NSError* error))completion {
    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    return [self requestPath:@"cards.json" method:RKRequestMethodGET object:nil parameters:parameters completion:completion];
}

- (NSOperation*)createPrintedCardFromTemplate:(Model_CardTemplate*)template completion:(void(^)(Model_PrintedCard* card, NSError* error))completion {
    Model_PrintedCard* card = [[Model_PrintedCard alloc] init];
    card.template = template;
    return [self requestPath:@"cards.json" method:RKRequestMethodPOST object:card parameters:@{} completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.lastObject, error);
    }];
}

#pragma mark - Read

- (RKObjectMapping*)readMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardRead class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"code"]];
    [mapping addAttributeMappingsFromDictionary:@{@"latitude": @"locationLatitude",
                                                  @"longitude": @"locationLongitude"}];
    [mapping addRelationshipMappingWithSourceKeyPath:@"card" mapping:self.cardMapping];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"current_card_content" toKeyPath:@"currentContent" withMapping:self.contentMapping]];
    return mapping;
}

- (NSArray*)readResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.readMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"reads.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.readMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"reads/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)readRequestDescriptor {
    RKObjectMapping* mapping = [RKObjectMapping requestMapping];
    [mapping addAttributeMappingsFromArray:@[@"code"]];
    [mapping addAttributeMappingsFromDictionary:@{@"locationLatitude": @"latitude",
                                                  @"locationLongitude": @"longitude"}];
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[Model_CardRead class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (NSOperation*)readCardWithCode:(NSString*)code completion:(void(^)(Model_CardRead* read, NSError* error))completion {
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:15 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        Model_CardRead* read = [[Model_CardRead alloc] init];
        [read setCode:code];
        
        if (status == INTULocationStatusSuccess) {
            [read setLocationLatitude:[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude]];
            [read setLocationLongitude:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude]];
        }
        
        [self requestPath:@"reads.json" method:RKRequestMethodPOST object:read parameters:nil completion:^(NSArray *results, NSError *error) {
            if (completion) {
                completion(results.lastObject, error);
            }
        }];
    }];
    return nil;
}

- (NSOperation*)getReadWithId:(NSString*)readId completion:(void(^)(Model_CardRead* read, NSError* error))completion {
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] appropriateObjectRequestOperationWithObject:nil method:RKRequestMethodGET path:[NSString stringWithFormat:@"reads/%@.json", readId] parameters:@{}];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        if (completion) {
            completion(mappingResult.array.lastObject, nil);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation];
    
    return operation;
}

#pragma mark - Type

- (RKObjectMapping*)typeMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardType class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted"]];
    
    RKObjectMapping* localizationsMapping = [RKObjectMapping mappingForClass:[Model_CardTypeLocalization class]];
    [localizationsMapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted"]];
    
    RKObjectMapping* languageMapping = [RKObjectMapping mappingForClass:[Model_Language class]];
    [languageMapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name", @"code"]];
    
    [localizationsMapping addRelationshipMappingWithSourceKeyPath:@"language" mapping:languageMapping];
    
    [mapping addRelationshipMappingWithSourceKeyPath:@"localizations" mapping:localizationsMapping];
    
    return mapping;
}

- (NSArray*)typeResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.typeMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"types.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.typeMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"types/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)typeRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.typeMapping.inverseMapping objectClass:[Model_CardType class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

#pragma mark - Template

- (RKObjectMapping*)templateMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[Model_CardTemplate class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"name", @"text"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"type" mapping:self.typeMapping];
    [mapping addRelationshipMappingWithSourceKeyPath:@"image" mapping:self.imageMapping];
    return mapping;
}

- (NSArray*)templateResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.templateMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"templates.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.templateMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"templates/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)templateRequestDescriptor {
    RKObjectMapping* mapping = [RKObjectMapping requestMapping];
    [mapping addAttributeMappingsFromArray:@[@"text", @"name"]];
    RKObjectMapping* imageMapping = [RKObjectMapping requestMapping];
    [imageMapping addAttributeMappingsFromArray:@[@"id"]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"image" mapping:imageMapping];
    return [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[Model_CardTemplate class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (NSOperation*)getMyTemplates:(void(^)(NSArray* templates, NSError* error))completion {
    return [self requestPath:@"templates.json" method:RKRequestMethodGET object:nil parameters:@{@"filter": @"user:me"} completion:completion];
}

- (NSOperation*)getPopularTemplates:(void(^)(NSArray* templates, NSError* error))completion {
    return [self requestPath:@"templates.json" method:RKRequestMethodGET object:nil parameters:@{@"filter": @"popular", @"sort": @"popular"} completion:completion];
}

- (NSOperation*)createTemplateWithName:(NSString*)name text:(NSString*)text image:(UIImage*)image completion:(void(^)(Model_CardTemplate* template, NSError* error))completion {
    return [self uploadImage:image completion:^(Model_Image *image, NSError *error) {
        if (!error && image) {
            Model_CardTemplate* template = [[Model_CardTemplate alloc] init];
            template.image = image;
            template.name = name;
            template.text = text;

            [self requestPath:@"templates.json" method:RKRequestMethodPOST object:template parameters:@{} completion:^(NSArray *results, NSError *error) {
                if (completion) completion(results.lastObject, error);
            }];
        } else {
            if (completion) completion(nil, error);
        }
    }];
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
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self settingsIDMapping] method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"settings/settingsID.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return @[ responseDescriptor ];
}

- (NSOperation*)getSettingsID:(void(^)(CTServerSettings* settingsID, NSError* error))completion
{
    
    CGFloat screenScale = [DeviceInfo screenScale];
    CGSize screenSize = [DeviceInfo screenSize];
    NSDictionary* parameters = @{ @"screenWidth" : @(screenSize.width), @"screenHeight" : @(screenSize.height), @"screenScale" : @(screenScale) };
    
    return [self requestPath:@"settings/settingsID.json" method:RKRequestMethodGET object:nil parameters:parameters completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.firstObject, error);
    }];
}

#pragma mark - Background animation settings

- (RKObjectMapping*) backgroundAnimationMapping
{
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [mapping addAttributeMappingsFromArray:@[@"epochtime", @"imageName", @"preAnimationPosition", @"postAnimationPosition", @"moveAnimationDuration", @"alphaAnimationDuration", @"backgroundColor", @"imagePath"]];
    return mapping;
}

- (NSArray*) backgroundAnimationResponseDescriptors
{
    RKResponseDescriptor* responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self backgroundAnimationMapping] method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"settings/backgroundAnimation.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return @[ responseDescriptor ];
}

- (NSOperation*)getBackgroundAnimationJSON:(void(^)(NSDictionary* settingsID, NSError* error))completion
{
    
    CGFloat screenScale = [DeviceInfo screenScale];
    CGSize screenSize = [DeviceInfo screenSize];
    NSDictionary* parameters = @{ @"screenWidth" : @(screenSize.width), @"screenHeight" : @(screenSize.height), @"screenScale" : @(screenScale) };

    return [self requestPath:@"settings/backgroundAnimation.json" method:RKRequestMethodGET object:nil parameters:parameters completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.firstObject, error);
    }];
}

#pragma mark - User

- (RKObjectMapping*)userMapping {
    RKObjectMapping* mapping = [RKObjectMapping mappingForClass:[CTUser class]];
    [mapping addAttributeMappingsFromArray:@[@"id", @"createdAt", @"updatedAt", @"deleted", @"email", @"username", @"password"]];
    [mapping addAttributeMappingsFromDictionary:@{@"fullname": @"name"}];
    return mapping;
}

- (NSArray*)userResponseDescriptors {
    RKResponseDescriptor *allResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.userMapping method:RKRequestMethodGET|RKRequestMethodPOST pathPattern:@"users.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKResponseDescriptor *singleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.userMapping method:RKRequestMethodGET|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE pathPattern:@"users/:id.json" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return @[allResponseDescriptor, singleResponseDescriptor];
}

- (RKRequestDescriptor*)userRequestDescriptor {
    return [RKRequestDescriptor requestDescriptorWithMapping:self.userMapping.inverseMapping objectClass:[CTUser class] rootKeyPath:nil method:RKRequestMethodPOST|RKRequestMethodPUT|RKRequestMethodPATCH|RKRequestMethodDELETE];
}

- (NSOperation*)signupUser:(CTUser*)user completion:(void(^)(CTUser* user, NSError* error))completion {
    return [self requestPath:@"users.json" method:RKRequestMethodPOST object:user parameters:@{} completion:^(NSArray *results, NSError *error) {
        if (completion) completion(results.firstObject, error);
    }];
}

@end
