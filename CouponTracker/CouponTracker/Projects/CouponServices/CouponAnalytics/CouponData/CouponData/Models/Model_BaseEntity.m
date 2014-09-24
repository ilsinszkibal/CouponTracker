//
//  Model_BaseEntity.m
//  Coupon
//
//  Created by Teveli László on 15/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "Model_BaseEntity.h"


@implementation Model_BaseEntity

@dynamic createdAt;
@dynamic updatedAt;
@dynamic createdBy;
@dynamic id;
@dynamic deleted;

+ (NSString*)entityName {
    return [NSStringFromClass(self) stringByReplacingOccurrencesOfString:@"Model_" withString:@""];
}

- (NSString*)identification {
    return [self.id stringValue];
}

+ (instancetype)insertObjectInManagedObjectContext:(NSManagedObjectContext*)managedObjectContext {
    Model_BaseEntity* object = [NSEntityDescription insertNewObjectForEntityForName:self.entityName inManagedObjectContext:managedObjectContext];
    object.createdAt = [NSDate date];
    return object;
}

- (NSFetchedResultsController*)fetchedResultsController {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:[self.class entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"deleted != NO"];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

@end
