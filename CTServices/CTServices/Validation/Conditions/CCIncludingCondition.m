//
//  CCContainingCondition.m
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCIncludingCondition.h"

@interface CCIncludingCondition ()

@property (nonatomic, strong) NSMutableSet* includingPhrases;
@property (nonatomic, strong) NSMutableSet* excludingPhrases;

@property (nonatomic, strong) NSMutableDictionary* minimumIncludingParts;
@property (nonatomic, strong) NSMutableDictionary* maximumIncludingParts;
@property (nonatomic, strong) NSMutableSet* excludingParts;

@end

@implementation CCIncludingCondition

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.includingPhrases = [NSMutableSet set];
        self.excludingPhrases = [NSMutableSet set];
        self.minimumIncludingParts = [NSMutableDictionary dictionary];
        self.maximumIncludingParts = [NSMutableDictionary dictionary];
        self.excludingParts = [NSMutableSet set];
    }
    return self;
}

- (void)excludePart:(CCIncludingPart)part {
    [self.excludingParts addObject:@(part)];
}

- (void)includePart:(CCIncludingPart)part {
    [self includePart:part minimum:1];
}

- (void)includePart:(CCIncludingPart)part minimum:(NSUInteger)minimum {
    [self.minimumIncludingParts setObject:@(minimum) forKey:@(part)];
}

- (void)includePart:(CCIncludingPart)part maximum:(NSUInteger)maximum {
    [self.maximumIncludingParts setObject:@(maximum) forKey:@(part)];
}

- (void)excludePhrase:(NSString*)phrase {
    [self excludePhrases:[NSSet setWithArray:@[phrase]]];
}

- (void)includePhrase:(NSString*)phrase {
    [self includePhrases:[NSSet setWithArray:@[phrase]]];
}

- (void)excludePhrases:(NSSet*)phrases {
    [self.excludingPhrases addObjectsFromArray:phrases.allObjects];
}

- (void)includePhrases:(NSSet*)phrases {
    [self.includingPhrases addObjectsFromArray:phrases.allObjects];
}

- (void)increasePartCount:(CCIncludingPart)part inDictionary:(NSMutableDictionary*)dictionary {
    NSNumber* number = @([dictionary[@(part)] integerValue] + 1);
    [dictionary setObject:number forKey:@(part)];
}

- (NSDictionary*)partsInString:(NSString*)string {
    NSMutableDictionary* parts = [NSMutableDictionary dictionary];
    for (NSNumber* part in @[@(CCIncludingPartNumeric),
                             @(CCIncludingPartAlphanumeric),
                             @(CCIncludingPartLetter),
                             @(CCIncludingPartLowercaseLetter),
                             @(CCIncludingPartUppercaseLetter),
                             @(CCIncludingPartWhitespace),
                             @(CCIncludingPartSymbol),
                             @(CCIncludingPartPunctuation)]) {
        [parts setObject:@0 forKey:part];
    }
    for (NSInteger index = 0; index < string.length; index++) {
        unichar character = [string characterAtIndex:index];
        BOOL matched = NO;
        if ([[NSCharacterSet alphanumericCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartAlphanumeric inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet decimalDigitCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartNumeric inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet letterCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartLetter inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartUppercaseLetter inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartLowercaseLetter inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartWhitespace inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet symbolCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartSymbol inDictionary:parts];
            matched = YES;
        }
        if ([[NSCharacterSet punctuationCharacterSet] characterIsMember:character]) {
            [self increasePartCount:CCIncludingPartPunctuation inDictionary:parts];
            matched = YES;
        }
        if (!matched) {
            [self increasePartCount:CCIncludingPartPunctuation inDictionary:parts];
        }
    }
    return parts.copy;
}

- (NSString*)errorMessageForString:(NSString*)string {
    for (NSString* phrase in self.includingPhrases) {
        if ([string rangeOfString:phrase options:NSCaseInsensitiveSearch].location == NSNotFound) {
            return [NSString stringWithFormat:@"Value does not contain phrase '%@'", phrase];
        }
    }
    for (NSString* phrase in self.excludingPhrases) {
        if ([string rangeOfString:phrase options:NSCaseInsensitiveSearch].location != NSNotFound) {
            return [NSString stringWithFormat:@"Value contains phrase '%@'", phrase];
        }
    }
    NSDictionary* parts = [self partsInString:string];
    for (NSNumber* partNumber in parts) {
        BOOL isExcluding = [self.excludingParts containsObject:partNumber];
        NSUInteger count = [parts[partNumber] integerValue];
        NSUInteger minCount = [self.minimumIncludingParts[partNumber] integerValue];
        NSUInteger maxCount = [self.maximumIncludingParts[partNumber] integerValue];
        NSString* partType = @"";
        switch (partNumber.integerValue) {
            case CCIncludingPartAlphanumeric: partType = @"alphanumeric"; break;
            case CCIncludingPartNumeric: partType = @"numeric"; break;
            case CCIncludingPartLetter: partType = @"letter"; break;
            case CCIncludingPartLowercaseLetter: partType = @"lowercase letter"; break;
            case CCIncludingPartUppercaseLetter: partType = @"uppercase letter"; break;
            case CCIncludingPartSymbol: partType = @"symbol"; break;
            case CCIncludingPartPunctuation: partType = @"punctuation"; break;
            case CCIncludingPartWhitespace: partType = @"whitespace"; break;
            default:
            case CCIncludingPartOther: partType = @"any other"; break;
        }
        if (isExcluding && count > 0) {
            return [NSString stringWithFormat:@"Should not contain %@ character", partType];
        } else if (minCount > 0 && minCount > count) {
            return [NSString stringWithFormat:@"Not enough %@ characters found (%d/%d)", partType, count, minCount];
        } else if (maxCount > 0 && maxCount < count) {
            return [NSString stringWithFormat:@"Too much %@ characters found (%d/%d)", partType, count, maxCount];
        }
    }
    return nil;
}

- (BOOL)validateWithValue:(id)value error:(NSError**)error {
    if ([value isKindOfClass:[NSString class]]) {
        NSString* string = value;
        NSString* errorMessage = [self errorMessageForString:string];
        if (errorMessage) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
            }
            return NO;
        } else {
            return YES;
        }
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:CCValidatorErrorDomain code:CCValidatorErrorCodeNotImplemented userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"%@ type is not implemented in this validator", [value class]]}];
        }
        return NO;
    }
}

@end
