//
//  CCDataManager.m
//  SplashApp
//
//  Created by Teveli László on 2013.11.03..
//  Copyright (c) 2013 László Teveli. All rights reserved.
//

#import "CCDataManager.h"

@implementation CCDataManager

- (id)init
{
    self = [super init];
    if (self) {
//        self.serverStore = [[CCServerStore alloc] init];
//        self.coreDataStore = [[CCCoreDataStore alloc] init];
//        self.coreDataStore.storeInMemory = NO;
//        [self addDataStore:self.serverStore];
//        [self addDataStore:self.coreDataStore];
//        self.mapping = [[CCStoreMapping alloc] initWithLocalDataStore:self.coreDataStore remoteDataStore:self.serverStore];
//        self.coreDataServerSync = [self setUpSynchronizationOfLocalDataStore:self.coreDataStore withRemoteDataStore:self.serverStore direction:LTDataStoreSyncDirectionBoth andMapping:self.mapping automatically:NO];
    }
    return self;
}

- (void)test {
//    LTManagedObjectContext* moc = self.coreDataStore.context;
//    Model_PrintedCard* item1 = [[Model_PrintedCard alloc] initWithEntity:[NSEntityDescription entityForName:@"PrintedCard" inManagedObjectContext:moc] insertIntoManagedObjectContext:moc];
//    [item1 setUpdatedAt:[NSDate date]];
//    NSError* error;
//    [moc save:&error];
    
//    [self.coreDataServerSync synchronize];
}

- (void)getObjectsOfClass:(Class)class {
//    LTDataDescriptor* descriptor = [[LTDataDescriptor alloc] initWithCount:LTDataDescriptorCountAll dataClass:class andIdentification:nil];
//    [self.coreDataServerSync fetchData:descriptor immediately:YES completionBlock:^(NSArray *results, NSError *error, BOOL finished) {
    
//    }];
}

- (void)getObjectForClass:(Class)class forId:(NSNumber*)itemId {
//    LTDataDescriptor* descriptor = [[LTDataDescriptor alloc] initWithCount:LTDataDescriptorCountOne dataClass:class andIdentification:@[itemId]];
//    [self.coreDataServerSync fetchData:descriptor immediately:YES completionBlock:^(NSArray *results, NSError *error, BOOL finished) {
    
//    }];
}

- (void)getCards {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_PrintedCard class]];
//    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    
//    [self _GETForPath:path parameters:parameters completionBlock:nil];
    
}

- (void)getMyCardWithCompletion:(void(^)(NSArray* result, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_MyPrintedCard class]];
//    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    
//    [self _GETForPath:path parameters:parameters completionBlock:^(RKMappingResult *result, NSError *error) {
//        if (completion)
//            completion(result.array, error);
//    }];
    
}

- (void)getPromotedCardsWithCompletion:(void(^)(NSArray* result, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_PromotedPrintedCard class]];
//    NSDictionary* parameters = @{@"fields": @" ,template.cardType.localizations.name,template.cardType.localizations.language.name"};
    
//    [self _GETForPath:path parameters:parameters completionBlock:^(RKMappingResult *result, NSError *error) {
//        if (completion)
//            completion(result.array, error);
//    }];
}

- (void)getCardContents:(int) cardID withCompletion:(void(^)(NSArray* result, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_CardContent class]];
//    NSDictionary* parameters = @{@"filter": [NSString stringWithFormat:@"card:%d", cardID] };
//    
//    [self _GETForPath:path parameters:parameters completionBlock:^(RKMappingResult *result, NSError *error) {
//        if (completion)
//            completion(result.array, error);
//    }];
}

- (void)getTemplates {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_CardTemplate class]];
//    [self _GETForPath:path parameters:nil completionBlock:nil];
}

- (void)readCardWithCode:(NSString*)code completion:(void(^)(Model_CardRead* read, NSError* error))completion {
//    Model_CardRead* read = [Model_CardRead insertObjectInManagedObjectContext:self.coreDataStore.context];
//    [read setCode:code];
//    //TODO: location
////    [read setLocationLatitude:@""];
////    [read setLocationLongitude:@""];
//    
//    NSString* path = [self.mapping remoteObjectNameForClass:[read class]];
//    
//    [self _POSTForPath:path body:read parameters:nil completionBlock:^(RKMappingResult *result, NSError *error) {
//        Model_CardRead* read = (Model_CardRead*)result.array.lastObject;
//        if (completion) {
//            completion(read, error);
//        }
//    }];
    
}

- (void)getCardForCode:(NSString*)code completion:(void(^)(Model_PrintedCard* card, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_PrintedCard class]];
//    [self _GETForPath:path parameters:@{@"filter": [NSString stringWithFormat:@"code:%@", code], @"limit": @"1", @"fields": @"all"} completionBlock:^(RKMappingResult *result, NSError *error) {
//        Model_PrintedCard* card = (Model_PrintedCard*)result.array.lastObject;
//        if (completion) {
//            completion(card, error);
//        }
//    }];
}

- (void)getUrlForImageId:(NSNumber*)identifier completion:(void(^)(NSURL* url, NSError* error))completion {
//    NSString* path = [self.mapping pathForObjectId:identifier ofClass:[Model_Image class]];
//    [self _GETForPath:path parameters:nil completionBlock:^(RKMappingResult *result, NSError *error) {
//        Model_Image* image = (Model_Image*)result.array.lastObject;
//        if (completion) {
//            completion([NSURL URLWithString:image.url], error);
//        }
//    }];
}

- (void)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion {
//    NSString* path = [self.mapping remoteObjectNameForClass:[Model_Image class]];
//    NSData* imageData = UIImageJPEGRepresentation(image, 1.0);
//    [self _POSTForPath:path body:@{@"name": @"name", @"file": [imageData base64EncodedStringWithOptions:0]} parameters:nil completionBlock:^(RKMappingResult *result, NSError *error) {
//        Model_Image* imageObject = (Model_Image*)result.array.lastObject;
//        if (completion) {
//            completion(imageObject, error);
//        }
//    }];
}

#pragma mark - Private

/**
 *  Start GET requests with given parameters
 *
 *  @param path       Path
 *  @param parameters Parameters
 *  @param block      Completionblock to handle
 */
/*
- (void) _GETForPath:(NSString*) path parameters:(NSDictionary*) parameters completionBlock:(RKMappingResultBlock)block
{
    
    [[CCNetworkManager sharedManager] startRequestForPath:path method:RKRequestMethodGET body:nil parameters:parameters completionBlock:^(RKMappingResult *result, NSError *error) {
        
        if ( error ) {
            DDLogError(@"CCDataManager _GETForPath: path %@ parameters %@ ERROR %@", path, parameters, error);
        } else {
            DDLogInfo(@"CCDataManager _GETForPath: path %@ parameters %@ SUCCESS array %@ dictionary %@ set %@", path, parameters, result.array, result.dictionary, result.set);
        }
        
        if ( block )
            block( result, error );
        
    }];
}
*/

/**
 *  Start POST request with given parameters
 *
 *  @param path       Path
 *  @param body       Message body
 *  @param parameters Parameters
 *  @param block      Completionblock to handle
 */
/*
- (void) _POSTForPath:(NSString*) path body:(id) body parameters:(NSDictionary*) parameters completionBlock:(RKMappingResultBlock)block
{
    [[CCNetworkManager sharedManager] startRequestForPath:path method:RKRequestMethodPOST body:body parameters:parameters completionBlock:^(RKMappingResult *result, NSError *error) {
        
        if ( error ) {
            DDLogError(@"CCDataManager _POSTForPath: path %@ body %@ parameters %@ ERROR %@", path, body, parameters, error);
        } else {
            DDLogInfo(@"CCDataManager _POSTForPath: path %@ body %@ parameters %@ SUCCESS array %@ dictionary %@ set %@", path, body, parameters, result.array, result.dictionary, result.set);
        }
        
        if ( block )
            block( result, error );
        
    }];
}
*/

@end
