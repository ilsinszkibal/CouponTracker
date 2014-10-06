//
//  CTValidTextField.m
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTValidTextField.h"

#import "UIFactory.h"
#import "CTColor.h"

@interface CTValidTextField () {
    
    BOOL _isValid;
    
}

@end

@implementation CTValidTextField

#pragma mark - Factory

+ (instancetype) createForDelegate:(id<CTTextFieldDelegate>) delegate placeHolder:(NSString*) placeHolder
{
    return [self createForDelegate:delegate placeHolder:placeHolder isAutoCorrect:NO];
}

+ (instancetype) createForDelegate:(id<CTTextFieldDelegate>) delegate placeHolder:(NSString*) placeHolder isAutoCorrect:(BOOL) isAutoCorrect
{
    CTValidTextField* validTextField = [[CTValidTextField alloc] init];
    
    validTextField.fieldDelegate = delegate;
    [validTextField setPlaceholder:placeHolder];
    
    if ( isAutoCorrect )
    {
        [validTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    }
    
    return validTextField;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        [self setTintColor:[UIColor whiteColor] ];
        [self setTextColor:[UIColor whiteColor] ];
        
        [UIFactory setBordersAndCornerToButton:self];
    }
    
    return self;
}

#pragma mark - Super

- (void) setPlaceholder:(NSString *)placeholder
{
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName: [CTColor placeHolderGray] }];
    
    [self setAttributedPlaceholder:attributedString];
}

- (CGRect) textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 8, 0);
}

- (CGRect) editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 8, 0);
}

#pragma mark - TextField delegate

- (void)textFieldDidChange:(UITextField*)textField {
    [self updateValidity];
}

#pragma mark - Setter/Getters

- (void) setValidationBlock:(BOOL (^)(NSString *))validationBlock
{
    _validationBlock = validationBlock;
    [self updateValidity];
}

#pragma mark- Validation changed

- (void) setFieldDelegate:(id<CTTextFieldDelegate>)fieldDelegate
{
    _fieldDelegate = fieldDelegate;
    [self updateValidity];
}

- (void)updateValidity {
    
    BOOL originalValidation = _isValid;
    
    if (self.validationBlock)
    {
        _isValid = self.validationBlock(self.text);
    }
    else
    {
        _isValid = YES;
    }
    
    //Validation changed
    if ( _isValid != originalValidation )
    {
        [self notifyDelegateOfChange];
    }
    
}

- (void) notifyDelegateOfChange
{
    
    if ( [self isValid] && [self.fieldDelegate respondsToSelector:@selector(textFieldDidBecameValid:) ] )
    {
        [self.fieldDelegate textFieldDidBecameValid:self];
    }
    else if ( [self isValid] == NO && [self.fieldDelegate respondsToSelector:@selector(textFieldDidBecameInvalid:) ] )
    {
        [self.fieldDelegate textFieldDidBecameInvalid:self];
    }
    
}

- (BOOL) isValid
{
    return _isValid;
}

@end
