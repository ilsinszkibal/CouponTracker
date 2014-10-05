//
//  CCContainingCondition.h
//  Coupon
//
//  Created by Teveli László on 16/03/14.
//  Copyright (c) 2014 Teveli László. All rights reserved.
//

#import "CCValidationCondition.h"

typedef enum {
    CCIncludingPartNumeric,
    CCIncludingPartLetter,
    CCIncludingPartAlphanumeric,
    CCIncludingPartLowercaseLetter,
    CCIncludingPartUppercaseLetter,
    CCIncludingPartSymbol,
    CCIncludingPartPunctuation,
    CCIncludingPartWhitespace,
    CCIncludingPartOther
} CCIncludingPart;

@interface CCIncludingCondition : CCValidationCondition

- (void)excludePart:(CCIncludingPart)part;
- (void)includePart:(CCIncludingPart)part;
- (void)includePart:(CCIncludingPart)part minimum:(NSUInteger)minimum;
- (void)includePart:(CCIncludingPart)part maximum:(NSUInteger)maximum;
- (void)excludePhrase:(NSString*)phrase;
- (void)includePhrase:(NSString*)phrase;
- (void)excludePhrases:(NSSet*)phrases;
- (void)includePhrases:(NSSet*)phrases;

@end
