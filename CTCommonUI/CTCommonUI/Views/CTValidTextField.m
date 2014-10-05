//
//  CTValidTextField.m
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTValidTextField.h"

@implementation CTValidTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self setValid:YES];
    }
    return self;
}

- (void)textFieldDidChange:(UITextField*)textField {
    [self updateValidity];
}

- (void)setValid:(BOOL)valid {
    [self updateValidity];
    _valid = valid;
}

- (void)updateValidity {
    if (self.validationBlock) {
        BOOL isValid = self.validationBlock(self.text);
        if (isValid && !self.isValid) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidBecameValid:)]) {
                [self.delegate textFieldDidBecameValid:self];
            }
        } else if (!isValid && self.isValid) {
            if ([self.delegate respondsToSelector:@selector(textFieldDidBecameInvalid:)]) {
                [self.delegate textFieldDidBecameInvalid:self];
            }
        }
        _valid = isValid;
    }
}

@end
